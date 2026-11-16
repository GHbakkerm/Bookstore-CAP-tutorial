using {
    cuid,
    managed,
    sap.common.Currencies
} from '@sap/cds/common';

namespace tutorial.db;

entity Books : cuid, managed {
    title       : String;
    author      : Association to Authors;
    genre       : Association to Genres;
    publishedAt : Date;
    pages       : Integer;
    price       : Decimal(9, 2);
    currency    : Association to Currencies;
    stock       : Integer;
    status      : Association to BookStatus;
    Chapters    : Composition of many Chapters
                      on Chapters.book = $self;
}

entity Genres {
    key code        : String;
        description : String;
}



type BookStatusCode : String(1) enum {
    Available = 'A';
    Low_stock = 'L';
    Unavailable = 'U';
}

entity BookStatus {
    key code        : BookStatusCode;
        criticality : Integer;
        displayText : String;
}

entity Authors : cuid, managed {
    name  : String;
    books : Association to many Books
                on books.author = $self;
}

entity Chapters : cuid, managed {
    key book   : Association to Books;
        number : Integer;
        title  : String;
        pages  : Integer;
}
