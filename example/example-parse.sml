fun exampleParse s findCharset =
  let
    open Gumbo

    val output = parse s
    val root_node = root output

    fun doChildren element f =
      let
         val cs = children element
      in
        if List.null cs then () else ( List.map f cs; () )
      end



    fun printAttributes attr = if List.null attr then () else
        print ( "Attrs: " ^ (String.concatWith "; " (List.map (fn(n,v) => n ^ " is " ^ v ) attr)) ^ "\n")

    fun doit node =
      case nodeType node of
           NodeElement =>
             let
               val e = nodeElement node
               val tn = tagName e
               val _ = print ("tagName is " ^ (showTagName tn) ^ "\n")
               val attr = tagAttributes e
               val _ = printAttributes attr
             in
               doChildren e doit
             end
         | NodeText => (print "nodeText: "; print ((nodeText node) ^ "\n") )
         | NodeWhitespace => print "is NodeWhitespace\n"
         | nt => print ( "NodeType is : " ^ ( showNodeType nt) ^ "\n")

    (*
    val _ = doit root_node
    val _ = print "\n\n"
    *)



    fun getTextList node : string list =
      case nodeType node of
           NodeElement =>
             let
                val e = nodeElement node
                val cs = children e
             in
               if List.null cs then [] else List.concat (List.map getTextList cs)
             end
         | NodeText => [nodeText node]
         | _ => []

    fun getText node : string = String.concat (getTextList node)


    fun getAttrValue (attr, name) =
      let
        fun doit []         = NONE
          | doit ((n,v)::t) = if n = name then SOME v else doit t
      in
        doit attr
      end


    val dataCharset = ref NONE

    fun doTagMetaElement e = case !dataCharset of SOME _ => () | NONE =>
      let
        val attr = tagAttributes e
        val charset = getAttrValue (attr, "charset")
      in
        case charset of SOME _ => dataCharset := charset | NONE =>
          case getAttrValue (attr, "http-equiv") of
               SOME http_equiv =>
                   if (String.map Char.toLower http_equiv) = "content-type"
                   then
                     ( case getAttrValue (attr, "content") of
                          SOME content => ( case findCharset content of SOME c => dataCharset := SOME c | NONE => () )
                        | _ => ()
                     )
                   else ()
             | _ => ()
      end


    val dataTitle = ref NONE

    fun doTagHead node =
      case nodeType node of
           NodeElement =>
             let
               val e = nodeElement node
             in
               case tagName e of
                   TagTitle => dataTitle := SOME (getText node)
                 | TagMeta  => doTagMetaElement e
                 | _ => ()
               ;
               doChildren e doTagHead
             end
         | _ => ()


    val dataLinks = ref []

    fun doTagA node =
      case nodeType node of
           NodeElement =>
             let
               val e = nodeElement node
               val attr = tagAttributes e
               val text = getText node
             in
               case getAttrValue (attr, "href") of
                    NONE => ()
                  | SOME href => dataLinks := (href, text)::(!dataLinks)
             end
         | _ => raise Gumbo "doTagA"


    val dataText = ref []

    fun doTagBody node =
      case nodeType node of
           NodeElement =>
             let
               val e = nodeElement node
             in
               case tagName e of
                    TagA => doTagA node
                  | TagP => dataText := "\n  "::(!dataText)
                  | _    => ()
               ;
               doChildren e doTagBody
             end
         | NodeText => dataText := (nodeText node)::(!dataText)
         | _ => ()
         (*
         | NodeWhitespace => print "is NodeWhitespace\n"
         | nt => print ( "NodeType is : " ^ ( showNodeType nt) ^ "\n")
         *)



    fun doTagHtml node =
      case nodeType node of
           NodeElement =>
             let
               val e = nodeElement node
             in
               case tagName e of
                   TagHead  => doTagHead node
                 | TagBody  => doTagBody node
                 | _        => doChildren e doTagHtml
             end
         | NodeWhitespace => ()
         | _ => raise Gumbo "doTagHtml"


    val _ = doTagHtml root_node

    val _ = destroy output

  in
    {
      title   = !dataTitle,
      body    = (String.concat (List.rev (!dataText))),
      charset = !dataCharset,
      links   = List.rev (!dataLinks)
    }
  end
