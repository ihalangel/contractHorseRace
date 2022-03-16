const Horses = artifacts.require("Horses");


contract('Horses', accounts => {
    [alice, bob, carlos, dani] = accounts;
    console.log('Alice:', alice, 'Bob', bob);



    let HorsesIntance;

    beforeEach async() => {
        HorsesIntance = await Horses.new();

    };


});