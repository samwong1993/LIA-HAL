filename = '.\results0.003.txt';
[ini,err,dis,obj_old,obj]=textread(filename,'%f%f%f%f%f','delimiter',',');

Y = [mean(ini);mean(err);mean(dis);mean(obj_old);mean(obj)]