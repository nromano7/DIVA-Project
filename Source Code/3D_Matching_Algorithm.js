/**
 * 
 */

function generateMatching(s_list,p_list,c_list,a_list){
	
	var ret = [];
	
	for(i = 0; i < a_list.length; i++){
		var temp = []
		for(j = 1; j < a_list[i].length; j++){
			temp.push(a_list[i][j].substring(1));
		}
		ret.push(temp);
	}
	
	var s_vector = [];
	for(i = 0; i < s_list.length; i++){
		s_vector.push(0);
	}
	var p_vector = [];
	for(i = 0; i < p_list.length; i++){
		p_vector.push(0);
	}
	var c_vector = [];
	for(i = 0; i < c_list.length; i++){
		c_vector.push(0);
	}
	
	function generateNaiveMatching(){
		var matching = [];
		var ret_slice = ret.slice();
		ret_slice = shuffle(ret_slice);
		for(i = 0; i < ret_slice.length; i++){
			if(s_vector[parseInt(ret_slice[i][0])] == 0 
			&& p_vector[parseInt(ret_slice[i][1])] == 0 
			&& c_vector[parseInt(ret_slice[i][2])] == 0){
				matching.push(ret_slice[i]);
				s_vector[parseInt(ret_slice[i][0])] = 1;
				p_vector[parseInt(ret_slice[i][1])] = 1;
				c_vector[parseInt(ret_slice[i][2])] = 1;
			}
		}
		return matching;
	}
	
	matching = generateNaiveMatching();

	var change = true;
	while(change == true){
		change = false;
		len = matching.length;
		for(i = 0; i < len; i++){
			var removedTup = matching.shift();
			s_vector[parseInt(removedTup[0])] = 0;
			p_vector[parseInt(removedTup[1])] = 0;
			c_vector[parseInt(removedTup[2])] = 0;
			
			var uncontradicting = [];
			for(j = 0; j < ret.length; j++){
				if(s_vector[parseInt(ret[j][0])] == 0
				&& p_vector[parseInt(ret[j][1])] == 0
				&& c_vector[parseInt(ret[j][2])] == 0)
					uncontradicting.push(ret[j]);
			}
			
			// buckets[0] = contradict with coord 0
			// buckets[1] = contradict with coord 1
			// buckets[2] = contradict with coord 2
			// buckets[3] = contradict with coord 1 & 2
			// buckets[4] = contradict with coord 0 & 2
			// buckets[5] = contradict with coord 0 & 1
			var buckets = [[],[],[],[],[],[]];
			for(j = 0; j < uncontradicting.length; j++){
				var contradicts = [false,false,false];
				if(uncontradicting[j][0] == removedTup[0])
					contradicts[0] = true;
				if(uncontradicting[j][1] == removedTup[1])
					contradicts[1] = true;
				if(uncontradicting[j][2] == removedTup[2])
					contradicts[2] = true;
				
				if(contradicts[0] == true 
				&& contradicts[1] == false 
				&& contradicts[2] == false){
					buckets[0].push(uncontradicting[j]);
				}
				else if(contradicts[0] == false 
					 && contradicts[1] == true 
					 && contradicts[2] == false){
					buckets[1].push(uncontradicting[j]);
				}
				else if(contradicts[0] == false 
						 && contradicts[1] == false 
						 && contradicts[2] == true){
						buckets[2].push(uncontradicting[j]);
					}
				else if(contradicts[0] == false 
						 && contradicts[1] == true 
						 && contradicts[2] == true){
						buckets[3].push(uncontradicting[j]);
					}
				else if(contradicts[0] == true 
						 && contradicts[1] == false 
						 && contradicts[2] == true){
						buckets[4].push(uncontradicting[j]);
					}
				else if(contradicts[0] == true 
						 && contradicts[1] == true 
						 && contradicts[2] == false){
						buckets[5].push(uncontradicting[j]);
					}
			}
			
			var best = [];
			var isEmpty = [false,false,false,false,false,false];
			for(j = 0; j < 6; j++){
				if(buckets[j].length == 0)
					isEmpty[j] = true;
			}
			console.log(isEmpty);
			
			if(!isEmpty[0] && !isEmpty[1] && !isEmpty[2]){
				loop1:
				for(j = 0; j < buckets[0].length; j++){
					loop2:
					for(k = 0; k < buckets[1].length; k++){
						loop3:
						for(l = 0; l < buckets[2].length; l++){
							var contradicts = [false,false,false];
							if(buckets[0][j][2] == buckets[1][k][2])
								contradicts[0] = true;
							if(buckets[0][j][1] == buckets[2][l][1])
								contradicts[1] = true;
							if(buckets[1][k][0] == buckets[2][l][0])
								contradicts[2] = true;
							
							if(!contradicts[0] && !contradicts[1] && !contradicts[2]){
								best.splice(0,best.length,buckets[0][j],buckets[1][k],buckets[2][l]);
								break loop1;
							}
							if(best.length == 2)
								continue;
							
							if(!contradicts[0]){
								best.splice(0,best.length,buckets[0][j],buckets[1][k]);
								continue;
							}
							if(!contradicts[1]){
								best.splice(0,best.length,buckets[0][j],buckets[2][l]);
								continue;
							}
							if(!contradicts[2]){
								best.splice(0,best.length,buckets[1][k],buckets[2][l]);
								continue;
							}
						}
					}
				}
			}
			else if(!isEmpty[0] && !isEmpty[1]){
				loop1:
				for(j = 0; j < buckets[0].length; j++){
					loop2:
					for(k = 0; k < buckets[1].length; k++){
						if(buckets[0][j][2] != buckets[1][k][2]){
							best.splice(0,best.length,buckets[0][j],buckets[1][k]);
							break loop1;
						}
					}
				}
			}
			else if(!isEmpty[0] && !isEmpty[2]){
				loop1:
				for(j = 0; j < buckets[0].length; j++){
					loop2:
					for(k = 0; k < buckets[2].length; k++){
						if(buckets[0][j][1] != buckets[2][k][1]){
							best.splice(0,best.length,buckets[0][j],buckets[2][k]);
							break loop1;
						}
					}
				}
			}
			else if(!isEmpty[1] && !isEmpty[2]){
				loop1:
				for(j = 0; j < buckets[1].length; j++){
					loop2:
					for(k = 0; k < buckets[2].length; k++){
						if(buckets[1][j][0] != buckets[2][k][0]){
							best.splice(0,best.length,buckets[1][j],buckets[2][k]);
							break loop1;
						}
					}
				}
			}
			
			if(best.length < 2){
				for(j = 0; j < 3; j++){
					if(!isEmpty[j] && !isEmpty[j+3]){
						best.splice(0,best.length,buckets[j][0],buckets[j+3][0]);
						break;
					}
				}
			}
			
			if(best.length >= 2){
				for(j = 0; j < best.length; j++){
					matching.push(best[j]);
					s_vector[parseInt(best[j][0])] = 1;
					p_vector[parseInt(best[j][1])] = 1;
					c_vector[parseInt(best[j][2])] = 1;
				}
				change = true;
			}
			else{
				matching.push(removedTup);
				s_vector[parseInt(removedTup[0])] = 1;
				p_vector[parseInt(removedTup[1])] = 1;
				c_vector[parseInt(removedTup[2])] = 1;
			}

			console.log(removedTup);
			console.log(best);
		}
		console.log(" ");
		console.log(" ");
		console.log(" ");
		console.log(len + " " + matching.length);
	}
	
	return matching;
}

function shuffle(array) {
  var currentIndex = array.length, temporaryValue, randomIndex;

  // While there remain elements to shuffle...
  while (0 !== currentIndex) {
	  
    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    // And swap it with the current element.
    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
  }

  return array;
}