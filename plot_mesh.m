function plot_mesh(X,connect,elemType,se,linewidth)

% function plot_mesh(X,connect,elem_type,linespec)
% 
% plots a nodal mesh and an associated connectivity.  X is
% the nodal coordinates, connect is the connectivity, and
% elemType is either 'T3', 'T6', 'H4', or 'H10' 
% depending on the element topology.
  
if ( nargin < 4 )
   se='w-';
end
if (nargin < 5)
    linewidth = 1.2;
end

holdState=ishold;
hold on

% fill X if needed
if (size(X,2) < 3)
   for c=size(X,2)+1:3
      X(:,c)=zeros(size(X,1),1);
   end
end

for e=1:size(connect,1)
  
   if ( strcmp(elemType,'T3') )  % 3-node triangle element
      ord=[1,2,3,1];
   elseif ( strcmp(elemType,'T6') )  % 6-node triangle element
      ord=[1,4,2,5,3,6,1];   
   elseif ( strcmp(elemType,'H4') )  % 4-node tet element
      ord=[1,2,4,1,3,4,2,3]; 
   elseif ( strcmp(elemType,'H10') )  % 10-node tet element
      ord=[1,5,2,6,3,7,1,8,4,9,2,6,3,10,4];   
   end
   
   xpt = zeros(1,size(ord,2));
   ypt = zeros(1,size(ord,2));
   zpt = zeros(1,size(ord,2));
   
   for n=1:size(ord,2)
      xpt(n)=X(connect(e,ord(n)),1);
      ypt(n)=X(connect(e,ord(n)),2);      
      zpt(n)=X(connect(e,ord(n)),3);
   end
   h=plot3(xpt,ypt,zpt,se);
   set(h,'LineWidth',linewidth);
   set(h,'MarkerSize',7);
end

rotate3d on
axis off
      
if ( ~holdState )
  hold off
end
