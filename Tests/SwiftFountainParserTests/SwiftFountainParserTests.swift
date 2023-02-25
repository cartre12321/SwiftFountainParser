import XCTest
@testable import SwiftFountainParser

final class SwiftFountainParserTests: XCTestCase {
    
    func testRegexes() throws {
        let script = """
        Title: Personal Comedy
        Author: Carter Riddall
        Contact:
            +1 (613) 617-4855
            carter.riddall@outlook.com



        # Act 1

        ## Opening Image

        EXT. STREET - DAY

        The opening notes to GREBFRUIT by Benny Greb play.
        Bright and sunny, the heat is radiating off the pavement.
        Suddenly, as the song's groove kicks in, something comes FLYING down the hill, zigging and zagging to avoid traffic and other obstacles.

        A young man, DARREN (19), skateboards down the street.
        He is wearing shorts, a ragged t-shirt, flip flops, sunglasses, and a bath robe: his imitation of the Dude.

        He rolls up to...

        INT. COFFEE SHOP - DAY

        Darren enters the shop, skateboard in hand. The CASHIER takes note of him.

        CASHIER
        Hey, you can't ride that in here.

        DARREN
        That's why it's in my hand.
        Can I get a large black coffee?

        The cashier silently rings him up.
        From behind, a VOICE is heard.

        VOICE
        Darren?

        Darren turns to see his friend STANLEY (19) sitting with two girls, MANDY and ALLISON (both also 19).
        Stanley gets up and approaches him.

        DARREN
        Stan! What're you doing here?

        STANLEY
        Man what the fuck are you wearing?

        DARREN
        Thought I'd shake things up, you kn--

        CASHIER
        (forcefully)
        Your change.

        Darren takes a coin from her outstretched hand.

        DARREN
        Thanks.
        (turning back to Stanley)
        What are you up to?

        STANLEY
        Not much, not much.
        Hey why don't you come sit with us?

        DARREN
        I don't have a lot of time...

        Stanley has already begun leading him back to the table. He addresses the two girls.

        STANLEY
        This is Darren. Darren,
        (pointing to each girl in turn)
        Mandy and Allison.

        Darren stays just behind Stanley.

        DARREN
        It's nice to meet you guys.

        MANDY
        You too!

        /*
        
        # Act 2A

        ## Midpoint

        = [[Gets into Shine Student Services?]]

        # Act 2B

        # Act 3

        ## Closing Image
        
        Action line that includes **bold**, *italic*, and _underlined_ text.
        
        */
        """
        
        let scriptElements = SwiftFountainParser().parseScript(script)
        
        let scriptPath = URL(fileURLWithPath: "/Users/carterriddall/Desktop/script/", isDirectory: true)
        
        if #available(macOS 13.0, *) {
            try scriptElements.toHTML().write(to: scriptPath.appending(component: "script.html"), atomically: true, encoding: .utf8)
        } else {
            try scriptElements.toHTML().write(to: scriptPath.appendingPathComponent("script.html"), atomically: true, encoding: .utf8)
        }
        
    }
}
