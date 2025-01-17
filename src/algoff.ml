open Tools
open Graph

(* Change le label des arcs en (flux(=0), capacité) *)
let make_graph_flow (gr : int graph) = 
  gmap gr (fun capacite -> (0,capacite))

(* Pour un arc de valeur (flot,capacité), remplace cet arc par   *)
(*  un arc du même sens de valeur capacité-flot et un arc de sens inverse de valeur flot *)
let add_splitted_edges (gr : int graph) (arc: (int*int) arc) = 
  let (flot, cap) = arc.lbl in
  let gr1 = new_arc gr {src = arc.src ; lbl = cap-flot; tgt = arc.tgt} in
  new_arc gr1 {src = arc.tgt ; lbl = flot; tgt = arc.src} 

(* Créé un graph d'écart *)
let make_graph_ecart gr =
  e_fold gr (fun gr1 a -> add_splitted_edges gr1 a) (clone_nodes gr)

(* Renvoie un chemin (=liste de noeuds) possible allant de src vers dest dans le graph gr *)
  let rec find_path (gr:int graph)  (src:id)  (dest:id) (acu:id list)= 
    (* tgt_list = tous les arcs sortant de src *)
    let tgt_list = out_arcs gr src in 
    let rec loop (gr:int graph)  (src2:id)  (dest2:id) (l :int arc list)(currentpath:id list) = 
    (* Pour chaque arc sortant, on va tenter de trouver un chemin allant jusqu'à dest *)
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
     loop gr src dest tgt_list acu
      
(* Trouve le flot minimum d'un chemin sur le graph gr *)    
let rec find_flot_min (gr:int graph) (chemin: id list) (min: int)=
let _affichage = Printf.printf "\nFlot: %d" min in
match chemin with
  | [] -> min
  | [_x] -> min
  | x :: y :: rest -> 
    match (find_arc gr x y) with
    | None -> min
    | Some x -> if (x.lbl<min) then (find_flot_min gr (y::rest) x.lbl) else (find_flot_min gr (y::rest) min)

(* Incrémente de valeur 'min' le flot des arcs correspondants au chemin 'chemin' dans le graph gr *)    
let rec increment_path (gr: int graph) (chemin: id list) (min: int) =
  match chemin with
  | [] -> gr
  | [_x] -> gr
  | x :: y :: rest -> 
    match (find_arc gr x y) with
    | None -> gr
    | Some arc -> increment_path (add_arc (add_arc gr arc.tgt arc.src (min)) arc.src arc.tgt (-min)) (y::rest) min
  let () = Printf.printf "\nincrementé!"

(* trouve le flot minimum d'un chemin et incrémente tout le chemin avec cette valeur minimum *)
let update_flow (gr: int graph) (chemin: id list) = increment_path gr chemin (find_flot_min gr chemin Int.max_int)

(* réalise l'algorithme de Ford-Fulkerson sur le graph gr,du noeud src vers le noeud dest *)
(* calcule le flot maximal du grah *)    
  let ford (gr: int graph) (src: id) (dest:id) =
    let () = Printf.printf "\ncommence ford" in
    let gr_flow = make_graph_flow gr in 
    let () = Printf.printf "\nfait le graphe de flow" in
    let gr_ecart = make_graph_ecart gr_flow in 
    let () = Printf.printf "\nfait le graphe d ecart" in
    let rec loop grl srcl destl =    
      let chemin = Option.map List.rev (find_path grl srcl destl []) in
      match chemin with 
     | None -> grl
     | Some path -> let _affichage = Printf.printf "\nchemin :" in
                    let () = List.iter (Printf.printf "  %d") (Option.get chemin) in
                    loop (update_flow grl path) srcl destl 
    in
    loop gr_ecart src dest
    let () = Printf.printf "\nfini!"
  
  
  
  
