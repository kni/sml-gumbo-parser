structure Gumbo : GUMBO =
struct

  datatype Output   = Output   of Foreign.Memory.voidStar
  datatype Node     = Node     of Foreign.Memory.voidStar
  datatype Document = Document of Foreign.Memory.voidStar
  datatype Element  = Element  of Foreign.Memory.voidStar

  open GumboCommon
  open Foreign
  structure C = GumboConstants


  val sizeofPointer = #size Foreign.LowLevel.cTypePointer

  val libgumbo = loadLibrary "libgumbo.so"

  val symbol_kGumboDefaultOptions = getSymbol libgumbo "kGumboDefaultOptions"


  local
    val parse_ffi = buildCall3 ((getSymbol libgumbo "gumbo_parse_with_options"), (cPointer, cString, cUint), cPointer)
  in
    fun parse s = Output (parse_ffi ((symbolAsAddress symbol_kGumboDefaultOptions), s, String.size s))
  end


  local
    val destroy_ffi = buildCall2 ((getSymbol libgumbo "gumbo_destroy_output"), (cPointer, cPointer), cVoid)
  in
    fun destroy (Output output) = destroy_ffi ((symbolAsAddress symbol_kGumboDefaultOptions), output)
  end


  fun readCString p =
    let
      fun len i = if Memory.get8 (p, i) = 0w0 then i else len (i + 0w1)
      val length = Word.toInt (len 0w0)
      fun getChar i = Byte.byteToChar (Memory.get8 (p, Word.fromInt i))
    in
      CharVector.tabulate(length, getChar)
    end

  fun readCStringP p = readCString (Memory.getAddress(p, 0w0))


  fun root (Output output) = Node (Memory.getAddress(Memory.++(output, sizeofPointer), 0w0))


  fun nodeType (Node node) = C.nodeTypeFromInt (Word32.toInt(Memory.get32(node, 0w0)))


  local
    fun nodeData node = Memory.++(node, (Word.fromInt C.offsetof_ActualNodeData))
  in
    fun nodeDocument (Node node) = Document     (nodeData node)
    fun nodeElement  (Node node) = Element      (nodeData node)
    fun nodeText     (Node node) = readCStringP (nodeData node)
  end


  local
    fun tagName' element = Word32.toInt(Memory.get32(Memory.++(element, (Word.fromInt C.offsetof_ElementTag)), 0w0))
  in
    fun tagName (Element element) = C.tagTypeFromInt (tagName' element)
  end


  fun gumboVector p =
    let
      val cnt_p = Memory.++(p, sizeofPointer)
      val cnt = Word.fromLargeWord(Word32.toLargeWord(Memory.get32(cnt_p, 0w0)))

      val data_p = Memory.getAddress(p, 0w0)
      fun data i = Memory.getAddress(Memory.++(data_p, sizeofPointer * (cnt - i)) , 0w0)

      fun loop 0w0 ps = List.rev ps
        | loop i   ps = ( loop (i-0w1) ((data i)::ps) )
    in
      loop cnt []
    end


  fun children (Element element) = List.map Node (gumboVector element)


  local
    fun tagAttributeNameValuse p =
      let
        val name_p  = Memory.++(p, (Word.fromInt C.offsetof_GumboAttributeName))
        val value_p = Memory.++(p, (Word.fromInt C.offsetof_GumboAttributeValue))
      in
        (readCStringP name_p, readCStringP value_p)
      end
  in
    fun tagAttributes (Element element) =
        let 
          val atts_p    = Memory.++(element, (Word.fromInt C.offsetof_ElementAttributes))
          val atts_list = List.map tagAttributeNameValuse (gumboVector atts_p)
        in atts_list end
  end

end
