open Graph



val make_graph_flow : int graph -> (int*int) graph

val add_splitted_edges : (int*int) graph -> 'a arc -> int graph

val make_graph_ecart : (int*'int) graph -> int graph