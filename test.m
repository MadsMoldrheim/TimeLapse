function test(a,k,step)
    for i = 1:step:10
        k = k+1;

    a = a*10;
    formatSpec = "%.i of %.i";
    A = [a k];
    fprintf(compose(formatSpec,A))
    end
end
