open Tools
open Graph

let make_graph_flow (gr : int graph) = 
  gmap gr (fun capacite -> (0,capacite))

let add_splitted_edges (gr : int graph) (arc: (int*int) arc) = 
  let (flot, cap) = arc.lbl in
  let gr1 = new_arc gr {src = arc.src ; lbl = cap-flot; tgt = arc.tgt} in
  new_arc gr1 {src = arc.tgt ; lbl = flot; tgt = arc.src} 

let make_graph_ecart gr =
  e_fold gr (fun gr1 a -> add_splitted_edges gr1 a) (clone_nodes gr)


  let rec find_path (gr:int graph)  (src:id)  (dest:id) (acu:id list)= 
    let tgt_list = out_arcs gr src in  
    let rec loop (gr:int graph)  (src2:id)  (dest2:id) (l :int arc list)(currentpath:id list) =
      match l with 
          |[] -> None (*pas de chemin trouve*)
          |x :: rest when (List.exists (fun treated -> (treated==x.tgt)) currentpath) -> loop gr src2 dest2 rest currentpath (*eliminer les noeuds deja consideres*)
          |x :: rest when (x.lbl==0) -> loop gr src2 dest2 rest currentpath (*eliminer les arcs avec une capacite a 0*)
          |x :: _ when x.tgt = dest2 -> Some (x.tgt::x.src::currentpath) (*on a atteint le puits*)
          |x :: rest ->  
              match (find_path gr x.tgt dest2 (x.src::acu)) with
                  |Some path -> Some path (*s'il existe une chemin, on le retourne*)
                  |None -> loop gr src2 dest2 rest currentpath (*on relance la boucle pour le prochain voisin*)
          in
    loop gr src dest tgt_list []

(*
let gmap_flow (gr: 'a graph_flow) (f: ('a -> 'b)) = 
  let graph = e_fold gr (fun x a -> (new_arc x {src = a.src ;lbl =(f a.lbl); tgt = a.tgt})) (clone_nodes gr) in graph (*utiliser fold pour appliquer la fonction f sur les noeuds et retourner un graphe*)
*)