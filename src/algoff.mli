open Graph



val make_graph_flow : int graph -> (int*int) graph

val add_splitted_edges : int graph -> (int*int) arc -> int graph

val make_graph_ecart : (int*int) graph -> int graph

val find_path : int graph -> id -> id -> id list -> id list option

val find_flot_min : int graph -> id list -> int -> int

val increment_path : int graph -> id list -> int -> int graph

val update_flow : int graph -> id list -> int graph

val ford : int graph -> id -> id -> int graph