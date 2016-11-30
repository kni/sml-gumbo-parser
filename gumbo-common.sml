(* Generated, do not edit. *)
structure GumboCommon : GUMBO_COMMON =
struct
  exception Gumbo of string

  datatype NodeType = NodeDocument
                    | NodeElement
                    | NodeText
                    | NodeCdata
                    | NodeComment
                    | NodeWhitespace
                    | NodeTemplate

  fun showNodeType NodeDocument = "Document"
    | showNodeType NodeElement = "Element"
    | showNodeType NodeText = "Text"
    | showNodeType NodeCdata = "Cdata"
    | showNodeType NodeComment = "Comment"
    | showNodeType NodeWhitespace = "Whitespace"
    | showNodeType NodeTemplate = "Template"

  datatype TagName = TagHtml
                   | TagHead
                   | TagTitle
                   | TagBase
                   | TagLink
                   | TagMeta
                   | TagStyle
                   | TagScript
                   | TagNoscript
                   | TagTemplate
                   | TagBody
                   | TagArticle
                   | TagSection
                   | TagNav
                   | TagAside
                   | TagH1
                   | TagH2
                   | TagH3
                   | TagH4
                   | TagH5
                   | TagH6
                   | TagHgroup
                   | TagHeader
                   | TagFooter
                   | TagAddress
                   | TagP
                   | TagHr
                   | TagPre
                   | TagBlockquote
                   | TagOl
                   | TagUl
                   | TagLi
                   | TagDl
                   | TagDt
                   | TagDd
                   | TagFigure
                   | TagFigcaption
                   | TagMain
                   | TagDiv
                   | TagA
                   | TagEm
                   | TagStrong
                   | TagSmall
                   | TagS
                   | TagCite
                   | TagQ
                   | TagDfn
                   | TagAbbr
                   | TagData
                   | TagTime
                   | TagCode
                   | TagVar
                   | TagSamp
                   | TagKbd
                   | TagSub
                   | TagSup
                   | TagI
                   | TagB
                   | TagU
                   | TagMark
                   | TagRuby
                   | TagRt
                   | TagRp
                   | TagBdi
                   | TagBdo
                   | TagSpan
                   | TagBr
                   | TagWbr
                   | TagIns
                   | TagDel
                   | TagImage
                   | TagImg
                   | TagIframe
                   | TagEmbed
                   | TagObject
                   | TagParam
                   | TagVideo
                   | TagAudio
                   | TagSource
                   | TagTrack
                   | TagCanvas
                   | TagMap
                   | TagArea
                   | TagMath
                   | TagMi
                   | TagMo
                   | TagMn
                   | TagMs
                   | TagMtext
                   | TagMglyph
                   | TagMalignmark
                   | TagAnnotationXml
                   | TagSvg
                   | TagForeignobject
                   | TagDesc
                   | TagTable
                   | TagCaption
                   | TagColgroup
                   | TagCol
                   | TagTbody
                   | TagThead
                   | TagTfoot
                   | TagTr
                   | TagTd
                   | TagTh
                   | TagForm
                   | TagFieldset
                   | TagLegend
                   | TagLabel
                   | TagInput
                   | TagButton
                   | TagSelect
                   | TagDatalist
                   | TagOptgroup
                   | TagOption
                   | TagTextarea
                   | TagKeygen
                   | TagOutput
                   | TagProgress
                   | TagMeter
                   | TagDetails
                   | TagSummary
                   | TagMenu
                   | TagMenuitem
                   | TagApplet
                   | TagAcronym
                   | TagBgsound
                   | TagDir
                   | TagFrame
                   | TagFrameset
                   | TagNoframes
                   | TagIsindex
                   | TagListing
                   | TagXmp
                   | TagNextid
                   | TagNoembed
                   | TagPlaintext
                   | TagRb
                   | TagStrike
                   | TagBasefont
                   | TagBig
                   | TagBlink
                   | TagCenter
                   | TagFont
                   | TagMarquee
                   | TagMulticol
                   | TagNobr
                   | TagSpacer
                   | TagTt
                   | TagRtc
                   | TagUnknown
                   | TagLast

  fun showTagName TagHtml = "Html"
    | showTagName TagHead = "Head"
    | showTagName TagTitle = "Title"
    | showTagName TagBase = "Base"
    | showTagName TagLink = "Link"
    | showTagName TagMeta = "Meta"
    | showTagName TagStyle = "Style"
    | showTagName TagScript = "Script"
    | showTagName TagNoscript = "Noscript"
    | showTagName TagTemplate = "Template"
    | showTagName TagBody = "Body"
    | showTagName TagArticle = "Article"
    | showTagName TagSection = "Section"
    | showTagName TagNav = "Nav"
    | showTagName TagAside = "Aside"
    | showTagName TagH1 = "H1"
    | showTagName TagH2 = "H2"
    | showTagName TagH3 = "H3"
    | showTagName TagH4 = "H4"
    | showTagName TagH5 = "H5"
    | showTagName TagH6 = "H6"
    | showTagName TagHgroup = "Hgroup"
    | showTagName TagHeader = "Header"
    | showTagName TagFooter = "Footer"
    | showTagName TagAddress = "Address"
    | showTagName TagP = "P"
    | showTagName TagHr = "Hr"
    | showTagName TagPre = "Pre"
    | showTagName TagBlockquote = "Blockquote"
    | showTagName TagOl = "Ol"
    | showTagName TagUl = "Ul"
    | showTagName TagLi = "Li"
    | showTagName TagDl = "Dl"
    | showTagName TagDt = "Dt"
    | showTagName TagDd = "Dd"
    | showTagName TagFigure = "Figure"
    | showTagName TagFigcaption = "Figcaption"
    | showTagName TagMain = "Main"
    | showTagName TagDiv = "Div"
    | showTagName TagA = "A"
    | showTagName TagEm = "Em"
    | showTagName TagStrong = "Strong"
    | showTagName TagSmall = "Small"
    | showTagName TagS = "S"
    | showTagName TagCite = "Cite"
    | showTagName TagQ = "Q"
    | showTagName TagDfn = "Dfn"
    | showTagName TagAbbr = "Abbr"
    | showTagName TagData = "Data"
    | showTagName TagTime = "Time"
    | showTagName TagCode = "Code"
    | showTagName TagVar = "Var"
    | showTagName TagSamp = "Samp"
    | showTagName TagKbd = "Kbd"
    | showTagName TagSub = "Sub"
    | showTagName TagSup = "Sup"
    | showTagName TagI = "I"
    | showTagName TagB = "B"
    | showTagName TagU = "U"
    | showTagName TagMark = "Mark"
    | showTagName TagRuby = "Ruby"
    | showTagName TagRt = "Rt"
    | showTagName TagRp = "Rp"
    | showTagName TagBdi = "Bdi"
    | showTagName TagBdo = "Bdo"
    | showTagName TagSpan = "Span"
    | showTagName TagBr = "Br"
    | showTagName TagWbr = "Wbr"
    | showTagName TagIns = "Ins"
    | showTagName TagDel = "Del"
    | showTagName TagImage = "Image"
    | showTagName TagImg = "Img"
    | showTagName TagIframe = "Iframe"
    | showTagName TagEmbed = "Embed"
    | showTagName TagObject = "Object"
    | showTagName TagParam = "Param"
    | showTagName TagVideo = "Video"
    | showTagName TagAudio = "Audio"
    | showTagName TagSource = "Source"
    | showTagName TagTrack = "Track"
    | showTagName TagCanvas = "Canvas"
    | showTagName TagMap = "Map"
    | showTagName TagArea = "Area"
    | showTagName TagMath = "Math"
    | showTagName TagMi = "Mi"
    | showTagName TagMo = "Mo"
    | showTagName TagMn = "Mn"
    | showTagName TagMs = "Ms"
    | showTagName TagMtext = "Mtext"
    | showTagName TagMglyph = "Mglyph"
    | showTagName TagMalignmark = "Malignmark"
    | showTagName TagAnnotationXml = "AnnotationXml"
    | showTagName TagSvg = "Svg"
    | showTagName TagForeignobject = "Foreignobject"
    | showTagName TagDesc = "Desc"
    | showTagName TagTable = "Table"
    | showTagName TagCaption = "Caption"
    | showTagName TagColgroup = "Colgroup"
    | showTagName TagCol = "Col"
    | showTagName TagTbody = "Tbody"
    | showTagName TagThead = "Thead"
    | showTagName TagTfoot = "Tfoot"
    | showTagName TagTr = "Tr"
    | showTagName TagTd = "Td"
    | showTagName TagTh = "Th"
    | showTagName TagForm = "Form"
    | showTagName TagFieldset = "Fieldset"
    | showTagName TagLegend = "Legend"
    | showTagName TagLabel = "Label"
    | showTagName TagInput = "Input"
    | showTagName TagButton = "Button"
    | showTagName TagSelect = "Select"
    | showTagName TagDatalist = "Datalist"
    | showTagName TagOptgroup = "Optgroup"
    | showTagName TagOption = "Option"
    | showTagName TagTextarea = "Textarea"
    | showTagName TagKeygen = "Keygen"
    | showTagName TagOutput = "Output"
    | showTagName TagProgress = "Progress"
    | showTagName TagMeter = "Meter"
    | showTagName TagDetails = "Details"
    | showTagName TagSummary = "Summary"
    | showTagName TagMenu = "Menu"
    | showTagName TagMenuitem = "Menuitem"
    | showTagName TagApplet = "Applet"
    | showTagName TagAcronym = "Acronym"
    | showTagName TagBgsound = "Bgsound"
    | showTagName TagDir = "Dir"
    | showTagName TagFrame = "Frame"
    | showTagName TagFrameset = "Frameset"
    | showTagName TagNoframes = "Noframes"
    | showTagName TagIsindex = "Isindex"
    | showTagName TagListing = "Listing"
    | showTagName TagXmp = "Xmp"
    | showTagName TagNextid = "Nextid"
    | showTagName TagNoembed = "Noembed"
    | showTagName TagPlaintext = "Plaintext"
    | showTagName TagRb = "Rb"
    | showTagName TagStrike = "Strike"
    | showTagName TagBasefont = "Basefont"
    | showTagName TagBig = "Big"
    | showTagName TagBlink = "Blink"
    | showTagName TagCenter = "Center"
    | showTagName TagFont = "Font"
    | showTagName TagMarquee = "Marquee"
    | showTagName TagMulticol = "Multicol"
    | showTagName TagNobr = "Nobr"
    | showTagName TagSpacer = "Spacer"
    | showTagName TagTt = "Tt"
    | showTagName TagRtc = "Rtc"
    | showTagName TagUnknown = "Unknown"
    | showTagName TagLast = "Last"

end
