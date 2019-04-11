%  
%  	   Macaco e a Banana
%      	                             
% Autor : Ivan Bratko    	     
% Adaptado por: Edjard Mota          
%      	                             
% estado inicial
%  - Macaco está na porta          naPorta    
%  - Macaco está no chão           noChao
%  - Caixa está na janela window   naJanela
%  - Macaco nao tem banana.        semBanana
%
%  Representação com functor state/4
%
%  state(naPorta,noChao,naJanela,semBanana)
%
% objetivo: chegar no estado state( _, _, _, comBanana)
%

% questão 1
% ?- podePegar(state(naPorta,noChao,naJanela,semBanana)).
% 
% no primeiro passo da execução, é encontrado match com a segunda clausula, que leva a mover o estado para um outro através da clausula move
% na clausula move é encontrado match apenas encontrado match com o move(anda), pela necessidade de os argumentos 1 e 3 serem diferentes
% o estado passa para (anonimo, noChao, naJanela, semBanana)
% a clausula podePegar é executada novamente, com o estado acima
% mais uma vez o match é com a segunda clasula podePegar, que leva a mais um movimento
% o argumento um do state é instanciado para naJanela, e o segundo argumento é instanciado para sobe, 
% logo, após isso o estado passa para (naJanela, sobreCaixa, naJanela, semBanana)
% mais uma vez, a clausula pode pegar é executada que gera novamente um match na segunda clausula, o que leva a mais um movimento
% desta vez, não há nenhum match por com o estado  (naJanela, sobreCaixa, naJanela, semBanana), o que gera um falha para o move e consequentemente para o podePegar com esta instanciado
% é refeita a partir da instancia state(naJanela, noChao, naJanela, semBanana), sendo instanciado o segundo argumento do move, agora para arrastar(naJanela, anonimo1), e state2(anonimo1, noChao, anonimo1, semBanana) 
% uma vez que os dois argumentos anonimos sao iguais, é encontrado match com a clausula move(sobe), o que deixa o estado como (anonimo1, sobreCaixa, anonimo1, semBanana)
% levando mais uma vez a execução do podePegar, que novamente leva a segunda clausula, que usa o move
% dessa vez, o move encontra um match com a clausula move(pega), visto que os dois argurmentos anonimos são iguais e o segundo argumento é sobreCaixa
% levando assim que os argumentos anonimos sejam instanciados para 'meio', que leva o estado à  state( meio, sobreCaixa, meio, comBanana) 
% após isso é executada novamente podePegar(state( meio, sobreCaixa, meio, comBanana)), que enfim encontra match com a primeira clausula podePegar e retorna true.


% continuacao questao 1, trocando a posicao do movimento anda
%
% quando se troca a posição, a clausula move (anda) executa indeterminadamente, causando estouro de pilha
% isso ocorre porque dado o comando podePegar(state(naPorta,noChao,naJanela,semBanana)). ,  haverá apenas a mudança do argumento 1, o estado atual do macaco
% isso ocorrendo, todas as proximos matchs irão cair nessa mesma clausula, não tendo portanto, uma condição de parada.
% no problema modelado, é como se o macaco ficasse apenas andando indeterminadamente.
% isso acontece pois a clausula move(anda) é a clausula mais genérica, devendo portanto, ser incluída após todas as clausulas mais espefícicas
                
% ‘pega’: 
move(state( meio, sobreCaixa, meio, semBanana), 
     pega,
     state( meio, sobreCaixa, meio, comBanana) ).    
% ‘sobe’: 
move(state( P, noChao, P, Has),
     sobe, 
     state( P, sobreCaixa, P, Has) ).
% ‘arrasta’:
move(state( P1, noChao, P1, Has),
     arrasta( P1, P2), 
     state( P2, noChao, P2, Has) ).
     
% ‘anda’:
move(state( P1, noChao, B, Has),
     anda( P1, P2), 
     state( P2, noChao, B, Has) ).   

% O macaco pode pegar banana busca o estado em
% o macaco pode pegar a bana.

podePegar(state(_,_,_, comBanana)).
podePegar(State1) :-
    move(State1, _, State2),
    podePegar(State2).

% linhas abaixo acrescentadas
podePegarComo(state(_,_,_, comBanana)).
podePegarComo(State1) :-
    write(State1), write(' -> '),
    move(State1, _, State2),
    write(State2), nl,
    podePegarComo(State2).

% terceira questão abaixo
% não consegui fazer com que o saída seja "Como = [lista de passos]  " , pois sempre é feito backtrack e a saída fica "Como = []"
% Mas consegui encontrar os passos e imprimi como saída.


addList(X, [], [X]).
addList(X, [Y|T], [Y|T1]) :- addList(X, T, T1).

podePegarComo(State1,Anterior,Como) :- podePegarComoAux(State1, Anterior, [], Como).

podePegarComoAux(state(_,_,_,comBanana), _, Como, Como).

podePegarComoAux(State1, [], Como, Acc) :- 
     move(State1, Move, State2),
     addList(Move, Como, Como2),
     podePegarComoAux(State2, [], Como2, Acc).

podePegarComoAux(State1, [H|T], Como, Acc) :-
     move(State1, H, State2),
     addList(H, Como, Como2),
     podePegarComoAux(State2, T, Como2, Acc).
