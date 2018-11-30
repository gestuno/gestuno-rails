# User profile CRUD logic


## USER

* On new (before first save), has no profile
* On save:
  - if interpreter?, attach interpreter profile
  - else, attach customer profile
* On destroy, destroy attached profile at same time

## PROFILE

* Dependent on user - can only be updated, never independently created/destroyed
* Cannot change user once attached
