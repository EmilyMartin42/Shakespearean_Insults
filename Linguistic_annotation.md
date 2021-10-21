# Linguistic Markup Methods

<i>Research Focus:<i> Does the type of relationship that characters/groups have correlate with the particular pragmatic features used to convey an insult between them?

## Types of Relationships

### Gender
Do gender differences have any impact on insults? 
<u>Markup:<u> `gender="female-male"` a woman insulting a man or `gender = '"male-female"` a man insulting a woman.

### Relationship
Does the relationship between the characters have any bearing on the insult?
<u>Markup:<u> `rel="parent-child"` a parent insults their child; `rel="child-parent"` a child insults their parent; `rel="sibling-sibling"`, a siblings insults another sibling; and finally `rel="friend-friend"`, a friend insults a friend.
    *note*: Even though things could get more complex with questions such as : do they both consider themselves friends or is one 'undercover' or even if the person they are insulting is not present in the scene we will treat them all the same for simplicities sake.

### Animosity 
Since things can get complicated, people aren't who they say they are, classification of villains vs heroes is hard we decided to have an attribute for animosity to gauge characters feelings for one another. This will enable us to look at the differences between insults amoung friends and enemies without having to classify characters in any grey areas.
<u>Markup:<u> `animosity="true"`; `animosity="false"`; `animosity="neutral"`

## Types of Linguistic Features

### Speech Acts
What illocutionary act is being commited by the speaker?
<u>Markup:<u> `act type="representative"` represents a state (i.e. suggesting, stating, describing); `act type="directive"` instruct the listener to take an action (i.e. commanding, challenging); `act type="commissive"` speaker commits to taking a future action (i.e. promising, threatening); `act type="expressive"` express the speaker's mental state in relation to a state (i.e. thanking, welcoming, apoligizing); `act type="declarative"` to bring the state being refrerenced into reality (i.e. blessing, baptizing, sentencing)

### Implicature
What is being implied by the speaker in order to insult the recipient/are the typical rules of conversation (see Grice's Maxims: `https://www.sas.upenn.edu/~haroldfs/dravling/grice.html`) being violated in order to imply an insult?
<u>Markup:<u> `imp type="qual"` to give the most accurate information possible; `imp type="quant"` to give the most appropriate amount of information possible; `imp type="rel"` to give the most relevant information possible; `imp type="man"` to gove the most clear, concise, and organized information as possible, avoiding ambiguity 

### Directness (literal vs. metaphor/simile) 
Is there a difference between insults were someone is 'a lily-livered toadstood' vs. '*like* a lily-livered toadstood'?
<u>Markup:<u> `literal="true"`; `literal="false"`