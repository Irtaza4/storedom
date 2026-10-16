# ODDLY — unusually good objects

## Identity
ODDLY is an independent, playful design store. It pairs editorial restraint with expressive objects: confident typography, tactile color, carefully timed motion and an unmistakable point of view. The initial visual reference is [Kraving by ALEX BENDER / FANCY](https://dribbble.com/shots/27367222-Kraving-Mobile-app-design-Cards-icons-6-6-3D-animation); the identity, layout, illustrations and interactions are original.

## Art direction
- Warm paper `#F7F5F0`, near-black plum `#292333`, signature violet `#7456C8`, acid lime `#E5F589`.
- Product stages use muted lavender, butter, sage and terracotta. Color changes carry through product details and the bag.
- Space Grotesk 500/700 for expressive display text; Manrope 400/600/700/800 for interface copy; DM Mono for labels, indices and editorial metadata. All fonts are local and ship with their licenses.
- Generous rounded stages, hairline dividers, numbered objects, circular stickers and a dark floating navigation bar.
- Original Canvas illustrations use gradients, highlights, occlusion and cast shadows. These are animated 2.5D objects, not rotatable 3D meshes.

## Screens
1. **Splash:** dark plum stage, floating Cloud headphones, oversized lime wordmark, intro progress and a working skip action. Automatically reveals the shop after 2.6 seconds.
2. **Discover:** three selectable featured objects, editorial title, search, category filters, price sorting and an animated product grid.
3. **Edits:** a distinct editorial collection page with animated Tech and Living scenes. Each opens a filtered catalogue.
4. **Product:** a full page reached by a shared-object Hero transition. Animated stage, live color choices, quantity control, expandable details, saved state and add-to-bag feedback.
5. **Saved:** a personal editorial collection driven by the same favorite state as product details and cards.
6. **Bag:** animated line items, editable quantities, correct variant colors, totals and a dedicated order summary.
7. **Checkout and confirmation:** validated delivery fields, order total and a demo-only completion screen. No payment data is requested or sent.

## Motion language
- Product float: sinusoidal 5–7 second loops, phase-offset by product; subtle rotational sway.
- Pointer tilt: restrained perspective responding to the pointer position on each object.
- Illustration painting is isolated in a RepaintBoundary; transforms animate independently.
- Product navigation: shared-object Hero plus 650ms eased fade/vertical movement; 450ms return.
- Main navigation: 350ms crossfade with a small horizontal shift; page content enters over 550ms.
- Feature selection: 450ms object crossfade and 600ms stage-color transition.
- Favorites scale between states; quantities and add-to-bag feedback use short switches.
- System reduced-motion settings disable continuous float/tilt and page route movement. Controllers are disposed with their widgets; offscreen sliver children are released.

## Architecture
- `lib/main.dart`: app lifetime and splash handoff.
- `lib/core/`: visual tokens, typography, and route choreography.
- `lib/models/`: immutable product catalogue.
- `lib/state/`: ChangeNotifier store controller, shared favorites and variant-aware bag.
- `lib/screens/`: independently structured app screens.
- `lib/widgets/`: reusable motion objects, feature stage, product cards and shared UI.
- `lib/art.dart`: offline procedural object illustrations.

## Responsive behavior and accessibility
Centered 1200px desktop composition, four-column catalogue and split product view; two-column phone catalogue and vertically stacked product details. Safe areas and scrollable screens account for keyboards and compact displays. Standard buttons have tooltips, product artwork has semantic labels, color options expose selection, and navigation exposes its active state.

## Scope and verification
A fully navigable local prototype. Bag and favorites are in memory and reset on restart. Production payments, accounts, inventory, order fulfillment and persistence are not connected. Test coverage includes product options, favorites across screens, quantity changes, checkout validation and clearing, splash completion, collection filters, animation/reduced motion and 360/430/1200px composition baselines.
