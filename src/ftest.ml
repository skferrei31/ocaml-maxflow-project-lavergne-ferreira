open Gfile
open Tools
open Algoff
    
let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and source = int_of_string Sys.argv.(2)
  and sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  (*let graph = from_file infile in*)
  (*let graph = clone_nodes (from_file infile) in*)
  (*let graph = gmap (from_file infile) (fun x -> string_of_int ((int_of_string x)+1))in*)
  let gr1 = gmap (from_file infile) (fun x -> (int_of_string x)) in
  (*let gr2 = add_arc gr1 1 5 999 in*)
  let _gr2 = make_graph_flow gr1 in 
  (*let graph = gmap gr3 (fun (x,y) -> (string_of_int x)^" / "^(string_of_int y)) in*)
  (*let _gr3 = make_graph_ecart gr2 in
  let _graph = gmap gr3 (fun x -> (string_of_int x)) in
  let _chemins =  find_path gr3 source sink [] in
  let () = Printf.printf "\nListe retournée : " in
  let () = List.iter (Printf.printf "  %d ") (Option.get chemins) in*)
  (*
  let flot_min = find_flot_min gr3 (Option.get chemins) Int.max_int in 
  let () = Printf.printf "\nValeur flot_min: %d" flot_min in
  *)
  (*let updated_graph = update_flow gr3 (Option.get chemins) in 
  let updated_graph_str = gmap updated_graph (fun x -> (string_of_int x)) in*)

  let finito = ford gr1 source sink in
  let finito_str = gmap finito (fun x -> (string_of_int x)) in
  let () = export finito_str outfile in

  (* Rewrite the graph that has been read. *)
  (*let () = write_file outfile graph in*)
  (*let () = export graph outfile in*)
  (*clone_nodes graph *) 

  ();
 




