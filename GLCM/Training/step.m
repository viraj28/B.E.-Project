function [step_value]=step(A)
step_value=0;
for i=1:16
    for j=1:16
        step_value=step_value+A(i,j);
    end
end