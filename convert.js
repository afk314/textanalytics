/**
 * Created by akimball on 1/24/17.
 */


var Promise = require("bluebird");
var async = require('async');
var config = require('config');
var logger = require('winston');
var recursive = require('recursive-readdir');

var MongoClient = Promise.promisifyAll(require("mongodb"));
const util = require('util');
var xml2js = require('xml2js');
var fs = require('fs');
var N3 = require('n3');

var marklogic = require('marklogic');
var my = require('./my-connection.js');
var db = marklogic.createDatabaseClient(my.connInfo);
var qb = marklogic.queryBuilder;
var fs = require('fs');

var writer = N3.Writer({ prefixes:
	{
		hwcv:   'http://metadata.healthwise.org/concept/concept_data#',
		content_asset_data:     'http://metadata.healthwise.org/content/content_asset_data#',
		content_asset_schema:     'http://metadata.healthwise.org/content/content_asset_schema#',
		skos:   'http://www.w3.org/2004/02/skos/core#',
		rdfs:   'http://www.w3.org/2000/01/rdf-schema#',
		rdf:    'http://www.w3.org/1999/02/22-rdf-syntax-ns#'
	}
});






function getDefinitions(offset, limit) {
	db.documents.query(
		qb.where(qb.byExample( {type: 'Definition'} ))
			.slice(offset, limit)
	).stream()
		.on('data', function(document) {
			var body = document.content.body.replace(/  /g, ' ');
			var resource = 'content_asset_data:'+document.content.hwid;

			writer.addTriple(   resource, 'content_asset_schema:full_text', '"'+body+'"');
			writer.addTriple(   resource, 'rdf:type', 'content_asset_schema:Definition');
		}).on('end', function() {
			console.log('We are done');


			writer.end(function (error, result) {
				fs.writeFile("/usr/local/tmp/content.n3", result, function(err) {
					if(err) {
						return console.log(err);
					}
					console.log("File saved successfully!");
				});
			});

		}).on('error', function(err) {
			console.log('Uh oh')
		});
}

function renderDefinitions() {
	getDefinitions(0,10000);
}

renderDefinitions();