const { MongoClient } = require("mongodb");

const url =
	"mongodb://root:secret@localhost:27004?directConnection=true&authSource=admin";

async function main() {
	let client;
	try {
		client = new MongoClient(url);
		await client.connect();
		console.log("connected to atlas server database");

		const coll = client.db("test").collection("coll");
		await coll.insertOne({ text: "hi" });

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
