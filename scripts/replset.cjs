const { MongoClient } = require("mongodb");

const url =
	"mongodb://mongo_1:27001,mongo_2:27002,mongo_3:27003/?replicaSet=rs0";

async function main() {
	let client;
	try {
		client = new MongoClient(url);
		await client.connect();
		console.log("replica set database connected");
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
