// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract RacesHorses {
    uint idnewrace=0;
    uint Mod1= 10 ** 1;
    uint private constant N_P= 20;
    error  CantRegister();
    
    
struct Race {
        string name;
        uint maxTickets;
        uint min_winners;
        uint max_winners;  //requisito
        uint w_continues; // requisito 
        uint[] premios;        
        Enrolled[] enrolled;
        Resultados[]resultados;
        uint hour; //hora de partida
        uint contRace; // contador  
         }
    
struct Enrolled{
    address ownerHorse;
    uint tokenid;
        }
    
struct Resultados{
    uint tokenid;
    uint score;
    uint additional;
    uint m1;
    uint m2;
    uint x;
    uint poinst; 
    uint Ppartida;
    uint llegada; // Puesto de llegada 
    uint premio1;
    uint premio2;
}    


    
   
 mapping(uint => Race)  RacesMap; 
 address[] WhitelisteContract;
  



  //CREATES function
 
function createrace(string memory name_,uint _maxTickets, uint _minWinners, uint  _maxWinners, uint _w_continues) public onlyOwner{
     idnewrace= idnewrace +1;
     Race storage r= RacesMap[idnewrace];
     r.name = name_;
     r.maxTickets= _maxTickets;
     r.min_winners = _minWinners;
     r.max_winners = _maxWinners;
     r.w_continues= _w_continues; 
 }   

function _horsesReady(uint _tokenId)internal {
uint lastrace=horses[_tokenId].races.lastrace;//Time: ultima carrera
uint timeLastRace= lastrace + 120;//Sumamos 5 minutos de sleep
require (timeLastRace < block.timestamp,"Horse not ready jet");
horses[_tokenId].races.lastrace=block.timestamp;
}

//Falta: Solo puede listarse si la carrera existe y se encuentra en estado de enlistamiento.
//Falta: Solo puede listar el dueño del tokenid_
//Falta: Es una function pausable  ?
//Falta: Es una function only Owner
// Devolver error del list cuando no enlista
// Misma cartera no puede inscribir mas de 2 caballos
// traer datos verdaderos de tokens
function listhorse(uint _race, uint _tokenId)  public payable   {
Race storage r= RacesMap[_race]; //Consulta a array Race
uint Ppartida = r.enrolled.length +1;
uint maxTickets=r.maxTickets;
require( Ppartida <= maxTickets,"Registrations closed" );
address owner = ERC721.ownerOf(_tokenId);             //Comprobamos owner
require(_msgSender() == owner,"caller is not owner"); // Comprobando owner
/*uint minWinners_r=r.min_winners;
uint maxWinners_r=r.max_winners;*/
_horsesReady(_tokenId);
_pushHorse(_tokenId,_race);

/*uint winners_h=horses[_tokenId].races.winners;  //Cargando datos de horse
/*uint continues=horses[_tokenId].races.continues;//Gamadas y continuas
string memory nameH=horses[_tokenId].name;//Cargando Datos Horses name
uint hb1=horses[_tokenId].hb1;     //Hb1  Hb2 y 3 + adicional
uint hb2=horses[_tokenId].hb2;     
uint hb3=horses[_tokenId].hb3;    //Adicional es  Healt + Jockey + herramientas 
uint score=hb1 + hb2 +hb3;             
//_pushHorse(_tokenId,timeLastRace,winners_h,_race);
if (winners_h >= minWinners_r && winners_h <= maxWinners_r){
r.horses.push(Horses(msg.sender,_tokenId));
//r.resultados.push(Resultados(_tokenId,score,1,0,0,0,0,Ppartida,0,0,0)); 
}
revert CantRegister();
*/
}

function _pushHorse(uint _tokenId,uint _race) internal{
Race storage r= RacesMap[_race]; //Consulta a array Race
//uint minWinners_r=r.min_winners;
//uint maxWinners_r=r.max_winners;
//uint winners_h=horses[_tokenId].races.winners;  //Cargando datos de horse
//if (winners_h >= minWinners_r && winners_h <= maxWinners_r){
r.enrolled.push(Enrolled(msg.sender,_tokenId));
//r.resultados.push(Resultados(_tokenId,score,1,0,0,0,0,Ppartida,0,0,0)); 
//}
//revert CantRegister();
} 


                     //               
/*uint additional=25;          //
uint ramdonmult1= _gRamMult(score);

 // Cargando Datos de Carrera
string memory stringdata="Inscrito";
*/

/*
if (winners_h >= minWinners_r && winners_ <= maxWinners_r){
    

}    
string memory stringdata="Inscrito";
uint N_p = N_P;   
Race storage r= RacesMap[race_];
uint race_winners = r.winners;
uint Ppartida = r.horses.length +1;
if (race_winners != 0){
if (Ppartida < N_p){  
//+Race.Resultados
r.horses.push(Horses(msg.sender,tokenid_,race_,Ppartida,0,21,22));

uint ramdonmult1= _gRamMult(score_);//multiplicador traido del listqr
//+Race.Resultados
r.resultados.push(Resultados(tokenid_,score_,5,ramdonmult1,0,0,0)); 
}else{ stringdata="Inscripciones finalizadas"; return (stringdata);}    
}else{ stringdata="Carrera no disponible"; return (stringdata);}}


function  playrace(uint idrace_) public onlyOwner{
Race storage r= RacesMap[idrace_];
uint Pp =r.horses.length - 1;
for (uint i = 0;  i <= Pp; i++ ){
uint tk_id=r.resultados[i].tokenid;
uint scr=r.resultados[i].score;
uint add=r.resultados[i].additional;
uint m1=r.resultados[i].m1;
uint m2= _gRamMult(tk_id);
uint ramdonmult3= _gRamMult(i);
uint poinst= _gPoinst(m1,m2,scr,add,ramdonmult3);
r.resultados[i]=(Resultados(tk_id,scr,add,m1,m2,ramdonmult3,poinst)); */

/*
function  playrace(uint idrace_) public onlyOwner{
Race storage r= RacesMap[idrace_];
uint Pp =r.horses.length - 1;
for (uint i = 0;  i <= Pp; i++ ){
uint tk_id=r.resultados[i].tokenid;
uint scr=r.resultados[i].score;
uint add=r.resultados[i].additional;
uint m1=r.resultados[i].m1;
uint m2= _gRamMult(tk_id);
uint ramdonmult3= _gRamMult(i);
uint poinst= _gPoinst(m1,m2,scr,add,ramdonmult3);
r.resultados[i]=(Resultados(tk_id,scr,add,m1,m2,ramdonmult3,poinst)); 
    

}*/











//Falta, crear desempate con el tokend de menor id minteo
function claimRewards(uint race_)public  {
Race storage r= RacesMap[race_]; 
uint Pp_c =r.enrolled.length - 1;
for (uint i = 0;  i <= Pp_c; i++ ){
uint tk_id=r.resultados[i].tokenid;
uint scr=r.resultados[i].poinst;
uint j=0;
uint llegada=Pp_c;
while ( j < Pp_c){    
uint tk_idj=r.resultados[j].tokenid;
uint scrj=r.resultados[j].poinst;


if ( scrj <= scr ) { 
//if (tk_id==tk_idj){ llegada     } 
if (scrj == scr && tk_idj > tk_id ){ llegada - 1;     } 

llegada -1; }

j++;
}
r.resultados[j].llegada =llegada ;
//r.enrolled[i].llegada =llegada ;
    
}
}

 /*   
function _listingPoinst( uint race_, uint i_,uint _Ppartida, uint tk_id_, uint scr_, uint add_, uint m1_,uint m2_,uint ram3_, uint poinst_)internal{
Race storage r= RacesMap[race_];
r.resultados[i_]=(Resultados(tk_id_,scr_,5,m1_,m2_,ram3_,poinst_,_Ppartida,0,0,0)); }
*/





// GET functions INTERNAL
function _gPoinst(uint m1_, uint m2_, uint scr_, uint add_,uint mul_ )internal pure returns(uint){
     uint poinst = 0;
     uint mul = mul_;
    if(mul==2){poinst= (scr_*m1_/m2_) + add_; }
    if(mul==3){poinst= (scr_*m2_/m1_) + add_; }
    if(mul==4){poinst= (scr_*m2_/m1_) + add_ +50; }
    if(mul==5){poinst= (scr_*m1_/m2_) + add_; }
    return(poinst);
} 
 
 
 
 
 function _gRamMult(uint N_) internal  view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(N_ , block.timestamp)));
        uint N= rand % Mod1;
        uint Nb= 0;
        if (N <=2){  Nb=2;}
        if (N == 3){  Nb=4;}
        if (N >3 && N<=6){ Nb=3;}
        if (N >6){  Nb=5;}
        return(Nb);
}





// GET function Public
function gListhorse(uint race_, uint tokenid_)  public view returns(uint inscritos,uint tk_id)  { 
//Traemos de horses en Race;
Race storage r= RacesMap[race_];
uint Tid=r.enrolled[tokenid_].tokenid;
uint uno=r.enrolled.length;
return(uno,Tid);
}



    
function gRResultados(uint race_, uint tokenid_)  public view returns(uint Tk_id,uint Score,uint additional,uint Mult1,uint Mult2,uint Pts)  { 
//Traemos de resultados en Race;
Race storage r= RacesMap[race_];
uint Tid=r.resultados[tokenid_].tokenid;
uint scr=r.resultados[tokenid_].score;
uint add=r.resultados[tokenid_].additional;
uint m1=r.resultados[tokenid_].m1;
uint m2=r.resultados[tokenid_].m2;
uint pts=r.resultados[tokenid_].poinst;
return(Tid,scr,add,m1,m2,pts);
}

function getRHorsesLenght(uint race_)public view returns(uint length){
Race storage r= RacesMap[race_];
uint uno =r.enrolled.length;
return(uno);
}


    
function getRace( uint idrace_) public view returns(string memory name,uint ganadores,uint Inscritos){
Race memory r= RacesMap[idrace_];
return (r.name, r.max_winners,r.enrolled.length); }
 
 
}