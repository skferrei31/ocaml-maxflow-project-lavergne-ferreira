(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr: 'a graph) = 
  n_fold gr (fun acu id -> new_node acu id) empty_graph

let gmap (gr: 'a graph) (f: ('a -> 'b)) = 
  let graph = e_fold gr (fun x a -> (new_arc x {src = a.src ;lbl =(f a.lbl); tgt = a.tgt})) (clone_nodes gr) in graph (*utiliser fold pour appliquer la fonction f sur les noeuds et retourner un graphe*)

let add_arc gr id1 id2 n = 
  match (find_arc gr id1 id2) with
  | None -> new_arc gr ({src = id1 ;lbl =n; tgt = id2})
  | Some arc -> new_arc gr {src = arc.src ;lbl = arc.lbl + n; tgt = arc.tgt}
(* Replace _gr and _f by gr and f when you start writing the real function. *)