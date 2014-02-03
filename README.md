# Hydramaton

This Rails application is to be the container for integrating and fleshing-out
Hydramata components.

As Hydramata are created they should make sure that they do not incorporate
knowledge of other Hydramata. They are distinct concerns that must be assembled
into a Hydramaton.

## Proposed Hydramata Components

* Hydramata::Core - Responsible for providing common functionality shared by Hydramata components.
* Hydramata::Layout - Stitches together a UI based on the exposed routes from the various Hydramata components.
* Hydramata::Deposit - Responsible for preparing a deposit. Analogous to writing a book.
* Hydramata::Institution - Responsible for Groups and Organizations; How people are organized.

## Speculative Hydramata Components

* Hydramata::Mediate - Responsible for mediating a deposit. Analogous to editing a book.
* Hydramata::Ingest - Responsible for ingesting into the repository. Analogous to printing the book.
