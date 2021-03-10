var config = {

	afkImage: "https://i.imgur.com/pgEPAV2.png", // you shouldnt need to change this, unless you want to. This is just the image at the top of the NUI

	Placeholder: "Set an AFK Status. (ex: Bathroom Break)", // The placeholder for the input box.

	requirements: `Do not go AFK for more than 20 minutes! `, // Requirements. Leave blank if you don't want anything

}


//---------------------------------------------------------------------------------------
//----------------------------DO NOT TOUCH BELOW!!!!!!!!---------------------------------
//---------------------------------------------------------------------------------------


document.write('<img src="' + config.afkImage + '">')
document.write('<h2>' + config.requirements + '</h2>')
document.write('<input placeholder="' + config.Placeholder + '" id="input"></input>')



