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
    val r = exampleParse s (fn _ => NONE)
  in
    print ("Charset: "  ^ ( showOptionString (#charset r)) ^ "\n");
    print ("Title: "    ^ ( showOptionString (#title r)) ^ "\n");
    print ("Body:"      ^ (#body r) ^ "\n");
    print ("Links:\n  " ^ (String.concatWith "\n  " (List.map (fn(href, text) => href ^ ": " ^ text) (#links r))) ^ "\n");
    print "\n"
  end

fun main () = main' () handle exc => print ("function main raised an exception: " ^ exnMessage exc ^ "\n")
