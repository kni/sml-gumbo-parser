signature GUMBO =
sig
  include GUMBO_COMMON

  type Output
  type Node
  type Document
  type Element

  val parse:   string -> Output
  val destroy: Output -> unit

  val root:    Output -> Node

  val nodeType: Node -> NodeType

  val nodeDocument: Node -> Document
  val nodeElement:  Node -> Element
  val nodeText:     Node -> string

  val children: Element -> Node list

  val tagName:       Element -> TagName
  val tagAttributes: Element -> (string * string) list
  val tagPosition:   Element -> int
end
