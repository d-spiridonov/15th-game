
function swap(index){
    if (index !== 3 && index !== 7 && index !== 11 && index !== 15 && appModel.get(index + 1).txt === 0){
        appModel.move(index, index + 1, 1);
    }
    else if (index > 3 && appModel.get(index - 4).txt === 0){
        appModel.move(index, index - 4, 1);
        appModel.move(index - 3, index, 1);
    }
    else if (index !== 0 && index !== 4 && index !== 8 && index !== 12 && appModel.get(index - 1).txt === 0){
        appModel.move(index, index - 1, 1);
    }
    else if (index < 13 && appModel.get(index + 4).txt === 0){
        appModel.move(index, index + 4, 1);
        appModel.move(index + 3, index, 1);
    }
    if (checkwinner() === true)
        winner.visible = true
}

function randomNumber(array){
    var index;
    var tmp;
    index = Math.floor(Math.random() * (15 - 0 + 1)) + 0;
    while (array[index] === 16)
        index = Math.floor(Math.random() * (15 - 0 + 1)) + 0;
    tmp = array[index];
    array[index] = 16;
    return tmp;
}

function randomize(array, tmp){
    for (var i = 0; i < 16; i++)
        array[i] = randomNumber(tmp);
}

function shuffle(){
    var array = new Array();
    while (array.length === 0 || isSolvable(array) === false)
    {
        var tmp = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        randomize(array, tmp);
    }
    for (var j = 0; j < 16; j++){
        var tmp = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
        appModel.append({"txt": array[j]});
    }
}

function checkwinner(){
    for (var i = 1; i < 15; ++i){
        if (appModel.get(i).txt < appModel.get(i - 1).txt)
            return false;
    }
    return true;
}


function getInvCount(array){
    var inv_count = 0;
    for (var i = 0; i < 15; i++){
        for (var j = i + 1; j < 16; j++){
            if (array[i] > array[j] && array[i] !== 0 && array[j] !== 0)
                inv_count++;
        }
    }
    return inv_count;
}

function findXPosition(array){
    for (var i = 0; array[i] !== 0; i++)
        continue
    if (i < 4)
        return 1;
    else if (i < 8)
        return 2;
    else if (i < 12)
        return 3;
    else if (i < 16)
        return 4;
}

function isSolvable(array){
    var invCount = getInvCount(array);
    var pos = findXPosition(array);
    if ((pos % 2 === 0 && invCount % 2 > 0) || (pos % 2 > 0 && invCount === 0))
        return true;
    else
        return false;
}
