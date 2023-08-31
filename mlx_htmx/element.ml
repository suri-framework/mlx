type t =
  | Node of { tag : string; attr : (string * string) list; children : t list }
  | Leaf of string

let rec to_tyxml (t: t) =
  match t with
  | Node {tag;attr;children} ->
      let children = List.map to_tyxml children in
      let a = List.map (fun (k,v) -> Tyxml.Xml.string_attrib k v ) attr in
      Tyxml.Xml.node tag ~a children
  | Leaf txt ->
      Tyxml.Html.txt txt |> Tyxml.Html.toelt


