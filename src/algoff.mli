open Graph



val make_graph_flow : int graph -> (int*int) graph

val add_splitted_edges : int graph -> (int*int) arc -> int graph

val make_graph_ecart : (int*int) graph -> int graph

val find_path : int graph -> id -> id -> int arc list