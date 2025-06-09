%%%%%%%%%%%%%%%%%%%%%%%%%%
% tree.pl
% https://gfx.cse.taylor.edu/courses/cos382/assignments/11_Paradigm_LogicProlog
% The goal of this assignment is to write a collection of Prolog rules
% to represent and manipulate binary trees.
%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%
% Starter code

% binary_tree(Tree)
% - Tree is a binary tree.

binary_tree(void).
binary_tree(tree(_, Left, Right)) :-
        binary_tree(Left),
        binary_tree(Right).


% tree_member(Tree, Element)
% - Element is an element of the binary tree Tree.

tree_member(tree(X, _, _), X).
tree_member(tree(_, Left, _), X)  :- tree_member(Left, X).
tree_member(tree(_, _, Right), X) :- tree_member(Right, X).



% preorder(Tree, Pre)
% - Pre is a list of elements of Tree accumulated during a preorder traversal.

preorder(tree(X, L, R), Xs) :-
        preorder(L, Ls),
        preorder(R, Rs),
        append([X|Ls], Rs, Xs).
preorder(void, []).


%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sample trees

%
%    tree1       tree2         tree3
%
%      1           4             1
%     / \         / \           / \
%    2   3       5   6         2   3
%                             / \
%                            5   6
%                               /
%                              7
%


%%%%%%%%%%%%%%%%%%%%%%%%%%
% Place your code here


% inorder/2
% inorder - returns a boolean of if In is an inorder traversal of a tree Tree
inorder(void, []). % basecase
inorder(tree(X, L, R), In) :-
    inorder(L, Ls), % left tree traversal
    inorder(R, Rs), % right tree traversal
    append(Ls, [X|Rs], In). % combined traversal with root node.

% subtree/2
% subtree - returns true of Subtree is a subtree of Tree
subtree(Tree, Tree). % basecase
subtree(tree(_, L, _), Subtree) :-
    subtree(L, Subtree). % check left subtree
subtree(tree(_, _, R), Subtree) :-
    subtree(R, Subtree). % check right subtree

% sumtree/2
% sumtree - for an integer tree get the sum of all nodes
sumtree(void, 0). % basecase
% we traverse the tree and add each node to our sum
sumtree(tree(X, Left, Right), Sum) :-
    sumtree(Left, LeftSum),
    sumtree(Right, RightSum),
    Sum is X + LeftSum + RightSum. % calculate sum

% ordered/1
% bigger helper
bigger(_, void). % basecase
bigger(X, tree(Y, Left, Right)) :-
    X > Y,
    bigger(X, Left),
    bigger(X, Right).

% smaller helper
smaller(_, void). % basecase
smaller(X, tree(Y, Left, Right)) :-
    X < Y, % X must be smaller than the root Y
    smaller(X, Left),
    smaller(X, Right).

% ordered - returns true if tree is a BST with NO duplicates
ordered(void). % basecase
ordered(tree(X, Left, Right)) :-
    smaller(X, Left),
    bigger(X, Right),
    ordered(Left),
    ordered(Right). % must meet all 4 conditions.

% pathto/3
% return true if [path] is a path to a key
pathto(void, _, []) :- !, fail. % basecase

pathto(tree(Key, _, _), Key, []). % key is root

pathto(tree(_, Left, _), Key, [left|Path]) :-
    pathto(Left, Key, Path). % key is in left subtree

pathto(tree(_, _, Right), Key, [right|Path]) :-
    pathto(Right, Key, Path). % key is in right subtree

% substitute/4
% - substitute is true when TreeY is the result of replacing all X in TreeX with Y
substitute(void, _, void, _). % basecase

% X is the root of TreeX
substitute(tree(X, Lx, Rx), X, tree(Y, Ly, Ry), Y) :-
    substitute(Lx, X, Ly, Y), % Recursively substitute in the left subtree
    substitute(Rx, X, Ry, Y). % Recursively substitute in the right subtree

% X is NOT the root of TreeX
substitute(tree(Z, Lx, Rx), X, tree(Z, Ly, Ry), Y) :-
    Z \= X,
    substitute(Lx, X, Ly, Y), % Recursively substitute in the left subtree
    substitute(Rx, X, Ry, Y). % Recursively substitute in the right subtree

% EXTRA CREDIT
% binsearch/2
% perform binary search for a key in a tree
binsearch(void, _) :- !, fail. % basecase

binsearch(tree(Key, _, _), Key) :- 
    write(Key),
    !. % key is at root

binsearch(tree(Root, Left, _), Key) :- 
    Key < Root,
    write(Root),
    binsearch(Left, Key). % key in lstree

binsearch(tree(Root, _, Right), Key) :- 
    Key > Root,
    write(Root),
    binsearch(Right, Key). % key in rstree

% prettyprint/1
% Did not complete

% Additional test data

% Trees for testing

tree1(T) :- T = tree(7, void, void).

tree2(T) :- T = tree(8, tree(4, tree(2, void, void), tree(6, void, void)), tree(12, tree(10, void, void), tree(14, void, void))).

tree3(T) :- T = tree(10, tree(5, tree(5, void, void), void), tree(15, tree(15, void, void), void)).

tree4(T) :- T = tree(7, tree(1, void, void), tree(5, void, void)).

tree33(T) :- T = tree(10, tree(5, tree(5, void, void), void), tree(155, tree(155, void, void), void)).