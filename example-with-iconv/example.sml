fun charsetFromBOM s =
  if String.size s < 4 then NONE else
  let open String in
    if isPrefix "\u00EF\u00BB\u00BF"       s then SOME ( "UTF-8"   , extract (s, 3, NONE) ) else
    if isPrefix "\u00FE\u00FF"             s then SOME ( "UTF-16BE", extract (s, 2, NONE) ) else
    if isPrefix "\u00FF\u00FE"             s then SOME ( "UTF-16LE", extract (s, 2, NONE) ) else
    if isPrefix "\u0000\u0000\u00FE\u00FF" s then SOME ( "UTF-32BE", extract (s, 4, NONE) ) else
    if isPrefix "\u00FF\u00FE\u0000\u0000" s then SOME ( "UTF-32LE", extract (s, 4, NONE) ) else
    NONE
  end


local
  open Scancom

  val takeWS = takeWhile Char.isSpace

  val scanner =
    takeStr "charset" *>
    takeWS *>
    takeStr "=" *>
    takeWS *>
    takeTill (fn c => Char.isSpace c orelse c = #";")

  val scanner = find scanner

in
  fun findCharset (s:string) : string option =
    case StringCvt.scanString scanner (String.map Char.toLower s) of
         NONE => NONE
       | SOME c => SOME (String.map Char.toUpper c)
end


fun readHtml () =
  let
    val args = CommandLine.arguments()
    val _ = if List.null args then print "Set file as argument.\n" else ()
    val file = List.nth(args, 0)
  in
    TextIO.inputAll (TextIO.openIn file)
  end


fun showOptionString os = case os of NONE => "NONE" | SOME v => "SOME " ^ v

fun main' () =
  let
    val s = readHtml ()
    val cBOM = charsetFromBOM s
    val s = case cBOM of NONE => s | SOME (c, s) => Iconv.iconv c "UTF-8" s
    val r = exampleParse s findCharset
    val r = case #charset r of NONE => r | SOME c => if c = "UTF-8" then r else exampleParse (Iconv.iconv c "UTF-8" s) findCharset
  in
    print ("Charset from BOM: "  ^ ( case cBOM of NONE => "NONE" | SOME (c, s) => "SOME " ^ c ) ^ "\n");
    print ("Charset: "  ^ ( showOptionString (#charset r)) ^ "\n");
    print ("Title: "    ^ ( showOptionString (#title r)) ^ "\n");
    print ("Body:"      ^ (#body r) ^ "\n");
    print ("Links:\n  " ^ (String.concatWith "\n  " (List.map (fn(href, text) => href ^ ": " ^ text) (#links r))) ^ "\n");
    print "\n"
  end

fun main () = main' () handle exc => print ("function main raised an exception: " ^ exnMessage exc ^ "\n")
