open Tools
open Graph

let make_graph_flow (gr : int graph) = 
  gmap gr (fun capacite -> (0,capacite))

let add_splitted_edges (gr : (int*int) graph) (arc: (int*int) arc) = 
  let (flot, cap) = arc.lbl in
  let gr1 = new_arc gr {src = arc.src ; lbl = cap-flot; tgt = arc.tgt} in
  new_arc gr1 {src = arc.tgt ; lbl = flot; tgt = arc.src} 

let make_graph_ecart gr =
  e_fold gr (fun gr a -> add_splitted_edges gr a) (clone_nodes gr)

  
(*
let gmap_flow (gr: 'a graph_flow) (f: ('a -> 'b)) = 
  let graph = e_fold gr (fun x a -> (new_arc x {src = a.src ;lbl =(f a.lbl); tgt = a.tgt})) (clone_nodes gr) in graph (*utiliser fold pour appliquer la fonction f sur les noeuds et retourner un graphe*)
*)