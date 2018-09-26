// Accepts a one dimentional array of integers
// Will find indexes where the value is less than any value to both left and right
// These values are described here as 'sunken'
// Will figure out how how deep the sink is
// Total sink volume for array returned

function enchanted_apples(arr){
    const arr_enchanted = new Array;
    let height,
        launch_height,
        index,
        mirror,
        enchantment,
        clearence,
        apples_rogue = 0;

    // The witch
    launch_height = arr[0];
    for (index in arr){
        height = arr[index]
        if (height > launch_height){
            launch_height = height;
        } else if (height < launch_height){
            arr_enchanted[index] = launch_height-height;
        }
    }

    // The apple god
    launch_height = arr[arr.length - 1];
    for (index in arr){
        mirror = arr.length - index -1;
        enchantment = arr_enchanted[mirror];
        height = arr[mirror];

        if (height > launch_height){
            launch_height = height;
        } else if (height < launch_height && enchantment){
            clearence = launch_height - height;
            lost_apples = clearence > enchantment ? enchantment : clearence;
            apples_rogue += lost_apples;
        }
    }
    console.log(apples_rogue);
}

test = [2,3,5,3,8,6,5,4,9,1,10,2];
enchanted_apples(test);