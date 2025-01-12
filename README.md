# Ocaml Project by Célia Lavergne, Aurélie Lacire and Sami-Koe Ferreira

This repository contains our code for the INSA **Ocaml project** on Ford-Fulkerson. The goal was to use the Ford-Fulkerson algorithm to implement an algorithm computing the max-flow of a given flow graph. Then we would find a use-case to use our code on to solve the problem.

<details>
<summary><strong>Guide to download and setup our project</strong></summary>

## Precisions
If you want to take a look at our code our modify it because you want to experiment with what we did, it will be easier for you to use VSCode as this project contains some simple configuration files to facilitate editing Ocaml in VSCode.

You will also need to download the *OCaml Platform* extension in VSCode. After that, just open VSCode in the root directory of this repository (command line: `code path/to/ocaml-maxflow-project`).

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).

## Download and setup
You just need to download the project and extract the code or clone our main branch onto your own device. No additional step is needed to setup our project, it has been made to be very simple to use!

</details>

<details>
<summary><strong>Use our project</strong></summary><br>

To use our project you will need to type command lines in a terminal on your own device, opened on our root directory. Then, you have two options depending on your needs/preferences.

## Option 1: Use our make file

### Simple Use
To use our project with the [`Makefile`](Makefile) we made, you need to type `make ...` followed by specific commands on your terminal. Here is the order in which you need to input the commands:

    make build
    make demo2

This will use a given file that represents a graph and execute our algorithm on it, turning it into a .svg file and opening it on firefox so you can immediately see it. Since all the files made using our code have the same name, if you want to save a particular version of a graph, just change the name of the graph you want to keep for later so our program doesn't overwrite it.

### Change arguments
If you want to use a particular graph or change which nodes are the source and destination, you need to edit the following lines of our makefile. They are normally at the top of it. Here is what they are for:

 - src?="source node" ; to define the source node of the graph
 - dst?="destination node" ; to define the destination node of the graph
 - graph?="graph.txt" ; the name of the input file, it can be either one of our premade files or a custom made file you created as long as it is stored in the `/graphs` directory of this project.

To create a custom made file it must follow the same format as our premade files, which is the following (based on graph1.txt file):

    %% Test graph #1
    
    %% Nodes - do not forget to specify "n" in the first column
    
    n  20 300 0   % This is node #0, with its coordinates x and y (which are not used by the algorithms but you need to specify it).
    n 200 300 1
    n 200 200 2
    n 200 400 3
    n 380 300 4
    n 380 200 5   % This is node #5.
    
    
    %% Edges (arcs) - do not forget to specify "e" in the first column
    
    e 0 2 0 8     % An arc from node 0 to node 2, labeled "8". The second 0 is useless (it's just a way to number every arcs).
    e 0 3 1 10
    e 0 1 2 7
    e 2 4 3 12
    e 3 4 4 5
    e 3 2 5 2
    e 3 1 6 11
    e 1 4 7 1
    e 1 5 8 21
    e 4 5 9 14    % An arc from 4 to 5 labeled 14. The 9 is useless.
    
    % End of graph

### Make command list
Here is a list of all the defined commands and a quick summary of what they do if you want to use them:

 - `make build` to compile. This creates an `ftest.exe` executable
 - `make demo2` to run the `ftest` program with some arguments and open the final graph using firefox
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts

## Option 2: Full command line

If you really hate using our makefile, you can <ins>first build and compile our project</ins> and then type a full command line which will need 5 arguments:

    ./ftest.exe infile source-id sink-id outfile

 - ./ftest.exe is necessary to run our program
 - infile is the input file in .txt format (using same format as explained in the Option 1 part);
 - source-id is the id of the source node;
 - sink-id is the id of the sink node;
 - outfile is what the name of the output file will be, you choose whatever you want b=but nore that it will be in .txt format regardless.

You can then use the given outfile as you wish.

</details>
