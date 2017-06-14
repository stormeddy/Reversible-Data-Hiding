function [g]=josephus(f,m)
    import josephus.Josephus
    n=numel(f);
    jo=josephus.Josephus;
    ind=jo.generate(n,m);
    g=f(ind);
end