(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes (gr: 'a graph) = 
  n_fold gr (fun acu id -> new_node acu id) empty_graph

let gmap gr f = 
  let graph = e_fold gr (fun e -> f e) in graph (*utiliser fold pour appliquer la fonction f sur les noeuds et retourner un graphe*)


let add_arc _a _b _c _d = assert false
(* Replace _gr and _f by gr and f when you start writing the real function. *)