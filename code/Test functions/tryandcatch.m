try  
    
    a = [1:1:50];
    for i = 50:-1:0
          
        x = a(i-20);  
        
    end
    
    a = 7/0; %result is Inf, not an error
    
    
catch ME
    
   ME  
    
end