structure Gumbo : GUMBO =
struct

  datatype Output   = Output   of MLton.Pointer.t
  datatype Node     = Node     of MLton.Pointer.t
  datatype Document = Document of MLton.Pointer.t
  datatype Element  = Element  of MLton.Pointer.t

  open GumboCommon
  open MLton.Pointer
  structure C = GumboConstants


  val kGumboDefaultOptions = _address "kGumboDefaultOptions": MLton.Pointer.t;


  local
    val parse_ffi = _import "gumbo_parse_with_options" : t * string * int -> t;
  in
    fun parse s = Output (parse_ffi (kGumboDefaultOptions, s, String.size s))
  end


  local
    val destroy_ffi = _import "gumbo_destroy_output" : t * t -> unit;
  in
    fun destroy (Output output) = destroy_ffi (kGumboDefaultOptions, output)
  end


  fun readCString p =
    let
      fun doit p l =
        let
          val w = getWord8(p, 0)
        in
          if w = 0w0
          then String.implode (List.rev l)
          else doit (add(p, 0w1)) ((Byte.byteToChar w)::l)
        end
    in
      doit p []
    end

  fun readCStringP p = readCString (getPointer(p, 0))


  fun root (Output output) = Node (getPointer(add(output, sizeofPointer), 0))


  fun nodeType (Node node) = C.nodeTypeFromInt (getInt32(node, 0))


  local
    fun nodeData node = add(node, (Word.fromInt C.offsetof_ActualNodeData))
  in
    fun nodeDocument (Node node) = Document     (nodeData node)
    fun nodeElement  (Node node) = Element      (nodeData node)
    fun nodeText     (Node node) = readCStringP (nodeData node)
  end


  local
    fun tagName' element = getInt32(add(element, (Word.fromInt C.offsetof_ElementTag)), 0)
  in
    fun tagName (Element element) = C.tagTypeFromInt (tagName' element)
  end


  fun gumboVector p =
    let
      val cnt_p = add(p, sizeofPointer)
      val cnt = Word.fromInt(getInt32(cnt_p, 0))

      val data_p = getPointer(p, 0)
      fun data i = getPointer(add(data_p, sizeofPointer * (cnt - i)) , 0)

      fun loop 0w0 ps = List.rev ps
        | loop i   ps = ( loop (i-0w1) ((data i)::ps) )
    in
      loop cnt []
    end


  fun children (Element element) = List.map Node (gumboVector element)


  local
    fun tagAttributeNameValuse p =
      let
        val name_p  = add(p, (Word.fromInt C.offsetof_GumboAttributeName))
        val value_p = add(p, (Word.fromInt C.offsetof_GumboAttributeValue))
      in
        (readCStringP name_p, readCStringP value_p)
      end
  in
    fun tagAttributes (Element element) =
        let 
          val atts_p    = add(element, (Word.fromInt C.offsetof_ElementAttributes))
          val atts_list = List.map tagAttributeNameValuse (gumboVector atts_p)
        in atts_list end
  end

end
