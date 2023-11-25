#!/usr/bin/env node
import fs from 'fs';
import Parser from 'rss-parser';

let parser = new Parser({
    customFields: {
    item: ['author_name', 'book_medium_image_url']
}});

const url = "https://www.goodreads.com/review/list_rss/150379591?key=WUhMZYCSeQn7n_6sqH20k8uhCzw_k-ltsbgRuk9duHVIx85q&shelf=to-read";

(async () => {
    let feed = await parser.parseURL(url);

    const books = feed.items.map(item => ({
        name: item.title,
        author: item.author_name,
    }));

    fs.writeFile('../website/_data/books.json', JSON.stringify(books), (err) => {
        if (err) throw err;
        console.log('Books saved to books.json');
    });
})();