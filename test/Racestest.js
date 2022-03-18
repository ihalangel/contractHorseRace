var ethers = require('ethers');


const Races = artifacts.require("RacesHorses");
const expect = require("chai").expect


const { providers, Contract } = require('ethers');
const registryAbi = require('../build/contracts/RacesHorses.json');

contract('Races', accounts => {
    [alice, bob, carlos, dani] = accounts;
    console.log('Alice:', alice, 'Bob', bob);


    let RacesIntance;

    beforeEach(async() => {
        RacesIntance = await Races.new();
        //  console.log("RacesInstance Instace", RacesIntance);

    });


    it('Puedo crear Carreras', async() => {
        // gasPrice = await RacesIntance.gListhorse(0, 0);


        console.log("tupax");
        /*   //HorsesIntance.method.safeMint(this, title, { from: alice, value: parsedAmount });
                  const options = ({ from: alice, gas: "0x5208" });
                  const reciept = await RacesIntance.createrace("Ra", 5, 0, 0, 0, options);


                      console.log(reciept);
           */
    });


});