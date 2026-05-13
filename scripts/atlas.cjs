const { MongoClient } = require("mongodb");

const url = "mongodb://root:secret@localhost:27004?directConnection=true";

async function main() {
	let client;
	try {
		client = new MongoClient(url);
		await client.connect();
		console.log("atlas database connected");
		await client.close();
	} catch (error) {
		console.error(error);
		if (client) {
			client.close();
		}
		process.exit(1);
	}
}

main();
