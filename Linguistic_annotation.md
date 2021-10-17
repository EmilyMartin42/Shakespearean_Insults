# Linguistic Markup Methods

## Types of relationships and linguistic features
Do the types of relationships between characters have an impact on the linguistic structure of an insult?

### Gender
Does gender have any impact on insults? 
<u>Markup:<u> `gender="female-male"` a woman insulting a man or `gender = '"male-female"` a man insulting a woman.

### Relationship
Does the relationship between the characters have any bearing on the insult/
<u>Markup:<u> `rel="parent-child"` a parent insults their child; `rel="child-parent"` a child insults their parent; `rel="sibling-sibling"`, a siblings insults another sibling; and finally `rel="friend-friend"`, a friend insults a friend.
    *note*: Even though things could get more complex with questions such as : do they both consider themselves friends or is one 'undercover' or even if the person they are insulting is not present in the scene we will treat them all the same for simplicities sake.

### Animosity 
Since things can get complicated, people aren't who they say they are, classification of villains vs heroes is hard we decided to have an attribute for animosity to gauge characters feelings for one another. This will enable us to look at the differences between insults amoung friends and enemies without having to classify characters in any grey areas.
<u>Markup:<u> `animosity="true"`; `animosity="false"`; `animosity="neutral"`

## Linguistic Features

### Literal vs. metaphor/simile 
Is there a difference between insults were someone is 'a lily-livered toadstood' vs. '*like* a lily-livered toadstood'?
<u>Markup:<u> `literal="true"`; `literal="false"`

### Part of Speech
Since POS is already tagged for us we won't have to do any markup but we plan to compare pos' between insult types/across relationship groups.


