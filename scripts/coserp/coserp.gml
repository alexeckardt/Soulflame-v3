// @desc
//
//http://paulbourke.net/miscellaneous/interpolation/
//
function coserp(y1, y2, mu) {
   var mu2 = (1-cos(pi*mu))/2;
   return(y1*(1-mu2)+y2*mu2);

}