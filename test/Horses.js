const Horses = artifacts.require("Horses");
const expect = require("chai").expect


contract('Horses', accounts => {
    [alice, bob, carlos, dani] = accounts;
    console.log('Alice:', alice, 'Bob', bob);



    let HorsesIntance;

    beforeEach(async() => {
        HorsesIntance = await Horses.new();

    });

    it('total supply o', async() => {
        const supply = await HorsesIntance.totalSupply()
        console.log(supply.toNumber());
        expect(supply.toNumber()).to.equal(0);


    });



});