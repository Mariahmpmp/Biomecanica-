%--------------------------------------------------------------------------
% This script computes the GENERALIZED FORCES VECTOR of the 1/2 HAT-Leg
% multibody model.
%
%--------------------------------------------------------------------------

% generalized forces vector
g = zeros( 3*nBodies, 1 ); % A matriz das forças generalizadas é iniciada como 
%sendo uma matriz zeros, posteriormente armazena os valores do vetor de
%força generalizado, sendo que o seu tamanho depende da seguinte expressão,
%3*nBodies

 % reaction force vector

RF = zeros( 3*nBodies, 1 ); % A matriz das forças de reação é iniciada como 
%sendo uma matriz zeros, posteriormente armazena os valores do vetor das
%forças de reação, sendo que o seu tamanho depende da seguinte expressão,
%3*nBodies       

for i = 1:length(body_RF) %Para cada corpo "i" do sistema, será calculada  
    % a força de reação "RF" utilizando as funções splines "splines_RF" e
    %"body_RF".
   
    RF(3*body_RF(i)-2) = ppval(splines_RF(1),t); 
    %ppval(splines_RF(1), t) retorna o valor interpolado das splines 
    % para o tempo t
    RF(3*body_RF(i)-1) = ppval(splines_RF(2),t);
    RF(3*body_RF(i)) = ppval(splines_RF(2),t)*(ppval(splines_RF(3),t)-y(3*body_RF(i)-2))...
                      + ppval(splines_RF(1),t)*(ppval(splines_RF(4),t)-y(3*body_RF(i)-1));
    % n4 = Fy * deltax + Fx * deltay
    % deltax = x_P - x_4
    % deltay = y_P - y_4
        
end 

for n = 1:nBodies %O segundo ciclo for atribui as forças calculadas 
    % (RF) aos componentes correspondentes do vetor de forças generalizadas g
    
    g(3*n-2) = RF(3*n-2); %O componente g(3*n-2) recebe o valor de RF(3*n-2)
    g(3*n-1) = -9.81*Mass(n,1) + RF(3*n-1);  %O componente g(3*n-1) 
    % é calculado aravés da subtração da força gravitica (9.81*Mass(n,1)) 
    % do componente RF(3*n-1)
    g(3*n) = RF(3*n); %O componente g(3*n) recebe o valor de RF(3*n)
    
end    

%--------------------------------------------------------------------------