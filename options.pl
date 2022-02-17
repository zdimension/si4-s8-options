
% CALCULATEUR D'OPTIONS SEMESTRE 8
% (c) 1989-2022 Tom Niget
% Programme testé sur 486-DX

% USAGE:
% ?- choix_options(+FILIERE, +OPTIONS DESIREES, +OPTIONS NON DESIREES, -OPTIONS1, -OPTIONS2)
% 
% NB: Les options doivent être spécifiées par ordre ALPHABETIQUE!

% EXEMPLE:
% Je suis en FISE, je veux Prog Fonc, je ne veux pas Algo / Capt / DevOps / PCP / Valo
% ?- choix_options(fise, [pf], [algo, capt, devops, pcp, valo], O1, O2)


% --------- IMPLEMENTATION ---------

sous_ens([], []).
sous_ens([E|Rest], [E|NRest]) :- sous_ens(Rest, NRest).
sous_ens([_|Rest], NRest) :- sous_ens(Rest, NRest).

liste_disjointe(A, B) :- \+ (member(Truc, A), member(Truc, B)). % disjoint = aucun élément à la fois dans A et dans B

and(A, B) :- A, B.
or(A, B) :- A; B.
xor(A, B) :- or(A,B), not(and(A, B)).
bool_egal(A, B) :- not(xor(A, B)).

nb_options2(fise, 4).
nb_options2(fisa, 3).

choix_options(Filiere, Oui, Non, O1, O2) :- 
    % premières options à choisir
    sous_ens([ai, algo, pcp, pf, pp], O1), length(O1, M), M=2,
    
    % deuxièmes options à choisir
    sous_ens([capt, devops, isa, isle, ra, reseau, soc, valo], O2), length(O2, N), nb_options2(Filiere, N),
    
    append(O1, O2, X),
    
    % incompatibilités entre matières
    not(sous_ens(X, [ai, pf])),
    not(sous_ens(X, [isle, valo])), 
    not(sous_ens(X, [algo, soc])),
    bool_egal(member(isa, X), member(devops, X)), % prendre isa <=> prendre devops
    not(sous_ens(X, [isa, reseau])),
    not(sous_ens(X, [pcp, ra])),
    
    sous_ens(X, Oui),
    liste_disjointe(Non, X).

