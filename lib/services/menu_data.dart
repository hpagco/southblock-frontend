import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/category.dart';
import '../models/item.dart';
import '../models/testimonial.dart';

// Hardcoded menu content (step 2). Step 5 replaces this with API data behind MenuRepository.

Item I(String n, String d, Kind k, int a, [int b = kDefaultAccent, String tag = '']) =>
    Item(n, d, k, Color(a), Color(b), tag);
List<Item> S(String sec, List<Item> l) => l.map((x) => x.copy(sec: sec)).toList();
List<Item> uniq(List<Item> l) {
  final seen = <String>{};
  return l.where((x) => seen.add(x.name)).toList();
}

// colors
const acai = 0xFF5B2A73, pk = 0xFFE0457B, gr = 0xFF7AC143, bl = 0xFF7FB9CC, ye = 0xFFFFC83D;
const orr = 0xFFF08A2E, tn = 0xFFE6B98A, rd = 0xFFD6334F, brn = 0xFF7A4A2A, pu = 0xFF8A5BB0;

// ───────────────────────── Menu data ─────────────────────────
final List<Item> acaiBowls = [
  I('Warrior Bowl', 'Acai, banana, blueberry, pineapple juice. Topped with granola, strawberry, blueberry, banana.', Kind.bowl, acai, rd),
  I('Warrior + Nutella Bowl', 'Warrior base with hazelnut spread. Topped with granola, strawberry, banana, Nutella.', Kind.bowl, acai, brn),
  I('Nutella Bowl', 'Acai, almond milk, banana, Nutella. Topped with granola, coconut, banana.', Kind.bowl, acai, brn),
  I('PBJ Bowl', 'Acai, peanut butter, banana, blueberry. Topped with granola, blueberry, banana.', Kind.bowl, acai, tn),
  I('Almond Butter Bowl', 'Acai, almond milk, banana. Topped with granola, blueberry, banana, almond butter.', Kind.bowl, acai, tn),
  I('Dubai Chocolate Bowl', 'Acai, banana, chocolate. Topped with granola, kataifi crunch, pistachio drizzle.', Kind.bowl, acai, 0xFF4A6B2A),
  I('Cali Vibes Bowl', 'Acai, banana, blueberry. Topped with granola, strawberry, banana, hemp hearts.', Kind.bowl, acai, gr),
  I('Aloha Bowl', 'Acai, pineapple, strawberry. Topped with granola, pineapple, coconut.', Kind.bowl, acai, ye),
  I('Loaded PBJ Bowl', 'Acai, peanut butter, banana. Loaded with granola, strawberry, banana, peanut butter.', Kind.bowl, acai, rd),
  I('Protein Warrior Bowl', 'Acai, 10g whey, banana, pineapple juice. Topped with granola, blueberry, banana.', Kind.bowl, acai, bl),
];
final List<Item> smoothieBowls = [
  I('Green Bowl', 'Spinach, almond milk, ginger, mango, banana. Topped with granola, blueberry, banana.', Kind.bowl, gr, rd),
  I('Magic Dragon Bowl', 'Pitaya, dragon fruit, pineapple, mango. Topped with granola, kiwi, coconut.', Kind.bowl, pk, ye),
  I('Mermaid Bowl', 'Pineapple juice, blue spirulina, banana, mango. Topped with granola, blueberry, strawberry.', Kind.bowl, bl, rd),
  I('Strawberry Bowl', 'Guava juice, strawberry, banana. Topped with granola, strawberry, blueberry.', Kind.bowl, 0xFFF26D7D, rd),
  I('Chocolate Covered Strawberry Bowl', 'Guava juice, strawberry, cacao. Topped with granola, Nutella, banana, strawberry.', Kind.bowl, 0xFFE0586A, brn),
  I('Mango Sunshine Bowl', 'Guava juice, banana, mango. Topped with granola, pineapple, strawberry.', Kind.bowl, ye, rd),
  I('Peanut Blast Bowl', 'Unsweetened almond milk, banana, peanut butter, whey. Topped with granola, strawberry, banana.', Kind.bowl, 0xFFE9CFA4, rd),
];
Item _mini(Item x) => x.copy(kind: Kind.mini, desc: 'Mini. ${x.desc}');
final List<Item> miniBowls = [
  ...acaiBowls.sublist(0, 9).where((x) => x.name != 'Aloha Bowl').map(_mini),
  _mini(I('Mighty Warrior Bowl', 'Acai, 10g whey, banana. Topped with granola, blueberry, banana.', Kind.mini, acai, rd)),
  ...smoothieBowls.map(_mini),
];
final List<Item> proteinSmoothies = [
  I('Daily Protein Smoothie', 'Unsweetened almond milk, banana, strawberry, acai, 25g whey protein.', Kind.cup, 0xFFE07A9A),
  I('Incredible Bulk Smoothie', 'Almond milk, banana, peanut butter, spinach, 30g whey protein.', Kind.cup, 0xFFA9B84A),
  I('Peanut Blast Smoothie', 'Unsweetened almond milk, banana, peanut butter, 30g whey protein.', Kind.cup, 0xFFECD9BC),
  I('Cave Monkey Smoothie', 'Almond milk, banana, peanut butter, raw cacao, 30g whey protein.', Kind.cup, tn),
  I('Wired Monkey Smoothie', 'Almond milk, banana, peanut butter, raw cacao, espresso, 30g whey.', Kind.cup, tn),
  I('Health Nut Smoothie', 'Almond milk, blueberries, mango, natural almond butter, acai, 30g whey.', Kind.cup, pu),
  I('Mother Earth Smoothie', 'Almond milk, spinach, banana, hemp, almond butter, cinnamon, 30g whey.', Kind.cup, 0xFFA7B05A),
  I('Greens + Protein Smoothie', 'Pineapple juice, kale, spinach, mango, banana, 30g whey protein.', Kind.cup, 0xFF7BB43A),
  I('Peanut Blast Smoothie + Spinach', 'Almond milk, banana, peanut butter, spinach, 30g whey protein.', Kind.cup, 0xFFC8DC7A),
  I('Almond Monkey Smoothie', 'Almond milk, banana, natural almond butter, raw cacao, 30g whey.', Kind.cup, tn),
];
final List<Item> superSmoothies = [
  I('Warrior Smoothie', 'Pineapple juice, acai, blueberry, banana, strawberry.', Kind.cup, 0xFFC0485A),
  I('Mermaid Smoothie', 'Pineapple juice, blue spirulina, banana, mango.', Kind.cup, bl),
  I('Pink Pitaya Smoothie', 'Pineapple juice, acai, dragon fruit, strawberry, mango.', Kind.cup, 0xFFD8267A),
  I('PBJ Smoothie', 'Almond milk, banana, blueberry, acai, peanut butter.', Kind.cup, 0xFF8A63A8),
  I('Strawberry Cloud Smoothie', 'Unsweetened almond milk, banana, strawberry, 10g collagen, coconut whip.', Kind.cup, 0xFFE8667A),
  I('Blue Sky Smoothie', 'Pineapple juice, blue spirulina, banana, mango, 10g protein.', Kind.cup, 0xFF3F8FCF),
];
final List<Item> greenSmoothies = [
  proteinSmoothies[6],
  proteinSmoothies[8],
  I('Tropi-Kale Smoothie', 'Coconut water, kale, mango, banana, ginger.', Kind.cup, 0xFF4A7A2A),
  proteinSmoothies[7],
  I('Super Green + Ginger Smoothie', 'Pineapple juice, kale, spinach, mango, banana, ginger.', Kind.cup, 0xFF68A832),
  I('Super Green Smoothie', 'Pineapple juice, kale, spinach, mango, banana.', Kind.cup, 0xFF74B838),
];
final List<Item> classicSmoothies = [
  I('Guava Breeze Smoothie', 'Guava juice, mango, banana.', Kind.cup, orr),
  I('Mango Mania Smoothie', 'Guava juice, banana, mango.', Kind.cup, ye),
  I('Strawberry Passion Smoothie', 'Guava juice, strawberry, banana.', Kind.cup, 0xFFF27A7A),
];
final List<Item> kidsSmoothies = [
  I('Guava Mini', 'Guava juice, strawberry, mango.', Kind.cup, orr),
  I('Strawberry Mini', 'Guava juice, strawberry, banana.', Kind.cup, 0xFFF27A7A),
  I('Mango Mini', 'Guava juice, banana, mango.', Kind.cup, ye),
  I('Green Mini', 'Pineapple juice, kale, spinach, mango, banana.', Kind.cup, 0xFF74B838),
];
final List<Item> toasts = [
  I('Avocado Toast', 'Smashed avocado, hemp hearts, crushed red pepper, sea salt.', Kind.toast, gr, rd),
  I('Loaded Egg Avocado Toast', 'Avocado, hemp hearts, crushed red pepper, boiled egg, microgreens.', Kind.toast, gr, 0xFFFFFFFF),
  I('Banana Almond Toast', 'Banana, almond butter, granola, honey, cinnamon.', Kind.toast, ye, brn),
];
final List<Item> juices = [
  I('Reset Juice', 'Cucumber, mint, apple, celery, kale, spinach, lemon.', Kind.juice, 0xFF4A6B2A),
  I('Rise Up Juice', 'Apple, celery, ginger, lemon, green beet.', Kind.juice, ye),
  I('Level Up Juice', 'Apple, spinach, kale, lemon.', Kind.juice, 0xFF3D6A28),
  I('Shine On Juice', 'Blueberry, apple, lime, green beet.', Kind.juice, 0xFFA3243B),
  I('All Heart Juice', 'Beet, apple, celery, ginger, pineapple.', Kind.juice, 0xFF6A1A3A),
  I('Brightside Juice', 'Mango, apple, lime, turmeric.', Kind.juice, ye),
  I('Daily Dose Shot', 'Ginger, turmeric, lemon, black pepper.', Kind.juice, 0xFFE8C13A),
];
final List<Item> grabAndGo = [
  I('Fiji (500 ml)', '', Kind.bottle, 0xFF3AA0D8),
  I('Spindrift - Raspberry Lime', '', Kind.can, 0xFFE8467A),
  I('Spindrift - Lemon', '', Kind.can, 0xFF8AB8E0),
  I('South Block Collagen Protein', 'Hydrolyzed bovine collagen protein.', Kind.bag, 0xFFBFE0F2),
  I('South Block Plant Protein', 'Organic pea protein, organic hemp protein, organic pumpkin seed protein.', Kind.bag, gr),
  I('South Block Whey Protein', '100% whey protein.', Kind.bag, 0xFFF2C94C),
];
final List<Item> seasonal = [
  I('Apple Crisp Acai Bowl', 'Acai, almond milk, bananas, blueberries. Topped with granola, apple, almond butter, honey, pumpkin seeds, cinnamon.', Kind.bowl, acai, rd),
  I('Apple Crisp Acai Bowl Mini', 'Acai, almond milk, bananas, blueberries. Topped with granola, apple, almond butter, honey, pumpkin seeds, cinnamon.', Kind.mini, acai, rd),
  I('Pumpkin Pie Smoothie', 'Pumpkin puree, pumpkin spice, banana, maple syrup, mango, almond butter, almond milk, cinnamon, Cocowhip.', Kind.cup, 0xFFE8892E),
  I('Great Pumpkin Bowl', 'Pumpkin puree, pumpkin spice, banana, maple syrup, mango, almond milk. Topped with granola, dates, pumpkin seeds, Cocowhip, cinnamon.', Kind.bowl, 0xFFE8892E, brn),
  I('Great Pumpkin Bowl Mini', 'Pumpkin puree, pumpkin spice, banana, maple syrup, mango, almond milk. Topped with granola, dates, pumpkin seeds, Cocowhip, cinnamon.', Kind.mini, 0xFFE8892E, brn),
];
final List<Item> yogurt = [
  I('Lean Green Protein Yogurt Smoothie', 'Greek yogurt, spinach, ginger, banana, mango.', Kind.cup, 0xFFB5D36A),
  I('Berry Glaze Protein Yogurt Bowl', 'Blueberry, Greek yogurt, granola, banana, strawberry, honey drizzle.', Kind.bowl, 0xFFF2ECE4, rd),
  I('Blueberry Almond Protein Yogurt Bowl', 'Greek yogurt, granola, blueberries, almond butter, honey.', Kind.bowl, 0xFFF2ECE4, 0xFF2E3B94),
  I('Apple Harvest Yogurt Bowl', 'Greek yogurt, granola, apple, pumpkin spice, almond butter, honey.', Kind.bowl, 0xFFF2ECE4, kDefaultAccent),
  I('Berry Balanced Protein Yogurt Smoothie', 'Banana, strawberry, blueberry, whey, Greek yogurt.', Kind.cup, 0xFF8E3F6A),
];

// ── Indian kitchen items ──
const cau = 0xFFE8B923, chk = 0xFFE4572E, sal = 0xFFE8845A, pan = 0xFFE9B44C, chp = 0xFFB9812F, grn = 0xFF6FAE3A, swt = 0xFFC2561F, qui = 0xFF8A6B3A;
final List<Item> bases = [
  I('Cauliflower Biryani', '', Kind.pot, cau, grn),
  I('Mixed Quinoa', '', Kind.pot, qui, rd),
  I('Shredded Cabbage & Spinach', '', Kind.pot, 0xFF7CC043, 0xFFC8E29A),
];
final List<Item> proteins = [
  I('Tandoori Chicken', '', Kind.pot, chk, ye),
  I('Honey Masala Chicken', '', Kind.pot, 0xFF8B2E1A, orr),
  I('Goan Glazed Salmon', '', Kind.pot, sal, grn),
  I('Spring Paneer', '', Kind.pot, pan, grn),
  I('Chickpea Chaat', '', Kind.pot, chp, grn),
];
final List<Item> hotSides = [
  I('Turmeric Coconut Dal', '', Kind.pot, 0xFFE6C02A, grn),
  I('Charred Honey Broccoli', '', Kind.pot, 0xFF4F8A2A, 0xFF2F5A1A),
  I('Golden Roasted Cauliflower', '', Kind.pot, ye, grn),
  I('Masala Spiced Sweet Potato', '', Kind.pot, swt, 0xFF7A2E12),
];
final List<Item> coldSides = [
  I('Kaana Kachumba Salad', '', Kind.pot, 0xFFD63A4A, grn),
  I('Roasted Masala Chickpea Salad', '', Kind.pot, chp, rd),
  I('Avocado, Mango and Greens', '', Kind.pot, grn, ye),
  I('Kaana Slaw', '', Kind.pot, ye, orr),
];
final List<Item> sauces = [
  I('Honey Masala Mustard Vinaigrette', '', Kind.sauce, 0xFFE0A21F),
  I('Tamarind Chutney', '', Kind.sauce, 0xFFB4421F),
  I('Coriander Chutney', '', Kind.sauce, grn),
  I('Mango Hot Sauce', '', Kind.sauce, orr, rd),
  I('Cucumber + Mint Raita', '', Kind.sauce, 0xFFEEF3EA, grn),
  I('Lime + Chilli Vinaigrette', '', Kind.sauce, 0xFF8A4A1F, rd),
];
final List<Item> toppings = [
  I('Red Chillies', '', Kind.sauce, 0xFFD6283A, 0xFF9E1A28),
  I('Green Chillies', '', Kind.sauce, 0xFF3F9A3A, 0xFF2A6A28),
  I('Kaana Crunchy Spice Mix', '', Kind.sauce, 0xFFD9A041, 0xFF8A5A1A),
  I('Lime Wedges', '', Kind.sauce, 0xFF9BC43A, 0xFFF2E68A),
  I('Pickled Red Onions', '', Kind.sauce, 0xFFB0307A, 0xFF7A1A56),
  I('Kaana Relish', '', Kind.sauce, 0xFFE0582A, 0xFFB03A1A),
  I('Roti', '', Kind.roti, 0xFFD9A867),
];
final List<Item> buildYourOwn = [
  ...S('01  Choose your base', bases),
  ...S('02  Pick your protein', proteins),
  ...S('03  Pick your sides: hot', hotSides),
  ...S('03  Pick your sides: cold', coldSides),
  ...S('04  Choose your sauce (as many as you like)', sauces),
  ...S('05  Add toppings (as many as you like)', toppings),
];
final List<Item> sides = [
  ...S('Protein pots', proteins),
  ...S('Veggie pots: hot', hotSides),
  ...S('Veggie pots: salads', coldSides),
];
final List<Item> indianBowls = [
  I('Golden Hour', 'Cauliflower Biryani, Tandoori Chicken or Spring Paneer (V), Turmeric Coconut Dal, Kaana Kachumba Salad, Cucumber + Mint Raita.', Kind.ibowl, cau, chk, 'GF'),
  I('Slaw and Order', 'Cauliflower Biryani, Honey Masala Chicken or Chickpea Chaat (VE), Golden Roasted Cauliflower, Kaana Slaw, Tamarind Chutney.', Kind.ibowl, cau, 0xFF8B2E1A, 'DF, GF'),
  I('Fishful Thinking', 'Mixed Quinoa, Goan Glazed Salmon, Golden Roasted Cauliflower, Avocado, Mango + Greens, Honey Masala Mustard Vinaigrette.', Kind.ibowl, qui, sal, 'DF'),
  I('Unbe-leaf-able', 'Shredded Cabbage and Spinach, Honey Masala Chicken or Chickpea Chaat (VE), Masala Spiced Sweet Potato, Roasted Masala Chickpea Salad, Lime Chilli Vinaigrette.', Kind.ibowl, 0xFF7CC043, swt, 'DF, GF'),
  I('Sweet, Spice & Everything Nice', 'Mixed Quinoa, Tandoori Chicken or Spring Paneer (V), Masala Spiced Sweet Potato, Charred Honey Broccoli, Coriander Chutney.', Kind.ibowl, qui, swt),
];
final List<Item> wraps = [
  I('Tandoori Chicken', 'Cauliflower Biryani, Tandoori Chicken, Kaana Kachumba Salad, Tamarind Chutney, Kaana Crunch.', Kind.wrap, chk, cau),
  I('Masala Honey Chicken', 'Shredded Cabbage and Spinach, Honey Masala Chicken, Kaana Slaw, Coriander Chutney, Kaana Crunch.', Kind.wrap, 0xFF8B2E1A, grn, 'DF'),
  I('Spring Paneer', 'Cauliflower Biryani, Spring Paneer, Kaana Kachumba Salad, Mango Hot Sauce.', Kind.wrap, pan, cau, 'V'),
  I('Chickpea Chaat', 'Shredded Cabbage and Spinach, Chickpea Chaat, Golden Roasted Cauliflower, Kaana Kachumba Salad, Tamarind Chutney.', Kind.wrap, chp, grn, 'DF, V, VG'),
];
final List<Item> drinksAndTreats = [
  ...S('Hot drinks', [
    I('Masala Chai', '', Kind.hot, 0xFFC98A4A),
    I('Pink Chai', '', Kind.hot, 0xFFD94A7A),
    I('Golden Chai', '', Kind.hot, 0xFFE8B923),
    I('Hot Chocolate', '', Kind.hot, 0xFF6B3A22),
    I('Selection of Teas', 'English Breakfast, Assam, Darjeeling, Peppermint, Lemon & Ginger', Kind.hot, 0xFFA9743A),
  ]),
  ...S('Cold drinks', [
    I('Sparkling Water', '', Kind.can, 0xFF222222),
    I('Still Water', '', Kind.can, 0xFFE8E8E8),
    I('Dash Water Peach', '', Kind.can, 0xFFE9835A),
    I('Trip CBD Elderflower Mint', '', Kind.can, 0xFFD8C4EC),
    I('Remedy Kombucha Raspberry Lemonade', '', Kind.can, 0xFFD6469A),
    I('Remedy Kombucha Ginger Lemon', '', Kind.can, 0xFFF0A31F),
    I('Marna Iced Tea Peach', '', Kind.can, 0xFF2E9AE0),
    I('Marna Iced Tea Mango', '', Kind.can, 0xFF2E9AE0),
    I('XOXO Lychee', '', Kind.can, 0xFFF2F2F2),
    I('XOXO Orange', '', Kind.can, orr),
    I('Coke Zero', '', Kind.can, 0xFFD6242F),
    I('Diet Coke', '', Kind.can, 0xFFCFCFCF),
  ]),
  ...S('Treats', [
    I('Chocolate Chip Cookie', '', Kind.cookie, 0xFFC28A4A, 0xFF4A2A1A),
    I('Cranberry Oatmeal Cookie', '', Kind.cookie, 0xFFC99A5A, 0xFFB0283A),
    I('Double Chocolate Cookie', '', Kind.cookie, 0xFF4A2A1E, 0xFF2A1A12),
    I('Barebells Protein Bar', '', Kind.bar, 0xFF3A3A3A),
    I('Hu Vanilla Crunch Chocolate Bar', '', Kind.bar, 0xFF5A3A28),
    I('Howdah Bombay Sweet Chilli Crisps', '', Kind.crisps, 0xFFE9703A),
    I('Howdah Onion Bhaji Crisps', '', Kind.crisps, 0xFFF1C232),
  ]),
];

final List<Cat> cats = [
  Cat('featured', 'Featured', C.blue, [seasonal[0], seasonal[2], seasonal[3], seasonal[4], ...yogurt]),
  Cat('acai-bowls', 'Acai Bowls', C.berry, acaiBowls),
  Cat('smoothie-bowls', 'Smoothie Bowls', C.pink, smoothieBowls),
  Cat('mini-bowls', 'Mini Bowls', C.green, miniBowls),
  Cat('protein-smoothies', 'Protein Smoothies', C.teal, proteinSmoothies),
  Cat('super-smoothies', 'Super Smoothies', C.forest, superSmoothies),
  Cat('green-smoothies', 'Green Smoothies', C.yellow, greenSmoothies, darkText: true),
  Cat('classic-smoothies', 'Classic Smoothies', C.lilac, classicSmoothies),
  Cat('kids-smoothies', 'Kids Smoothies', C.blue, kidsSmoothies),
  Cat('toasts', 'Toasts', C.forest, toasts),
  Cat('juices', 'Juices', C.yellow, juices, darkText: true),
  Cat('grab-and-go', 'Grab and Go', C.lilac, grabAndGo),
  Cat('build-your-own', 'Build Your Own', const Color(0xFFD9531E), buildYourOwn,
      divider: true, intro: "Build your thali: a nod to India's timeless way of eating. Pick a base, a protein, your sides, sauces and toppings."),
  Cat('sides', 'Sides', const Color(0xFF6B8E23), sides,
      intro: 'A little something on the side. Pick a pot of your favorite protein, hot side or salad as the perfect add-on or snack.'),
  Cat('indian-bowls', 'Indian Bowls', const Color(0xFFC0392B), indianBowls),
  Cat('wraps', 'Wraps', const Color(0xFFB7791F), wraps,
      intro: 'Four chef-created combinations that bring big flavor to every bite. Perfect for life on the move.'),
  Cat('drinks-treats', 'Drinks & Treats', const Color(0xFF6B4AA0), drinksAndTreats),
];

/// Home chips pull from the SAME menu lists, so each tab shows different real items.
final List<HomeCat> homeCats = [
  HomeCat('Seasonal', seasonal[0], seasonal, 'featured'),
  HomeCat('Protein Picks', proteinSmoothies[2], uniq([...yogurt, ...proteinSmoothies]), 'protein-smoothies'),
  HomeCat('Bowls', acaiBowls[0], uniq([...acaiBowls, ...smoothieBowls]), 'acai-bowls'),
  HomeCat('Smoothies', superSmoothies[2], uniq([...superSmoothies, ...classicSmoothies, ...greenSmoothies]), 'super-smoothies'),
  HomeCat('Toast', toasts[0], toasts, 'toasts'),
  HomeCat('Juice', juices[0], juices, 'juices'),
];

const List<Testimonial> testimonials = [
  Testimonial('The Warrior Bowl with honey, chia and cinnamon was a 10/10.', 'Placeholder from AZ'),
  Testimonial('Bowl was delicious. Staff was friendly and attentive. Highly recommend.', 'Placeholder from NC'),
  Testimonial('My second time going and it was great. Friendly workers, fresh ingredients.', 'Placeholder from NC'),
  Testimonial('Definitely a quick breakfast boost. The server gave a great suggestion.', 'Placeholder from VA'),
  Testimonial('Love eating here! Always fresh ingredients.', 'Placeholder from VA'),
  Testimonial('Always quality food and great service. Online ordering is very efficient.', 'Placeholder from VA'),
  Testimonial('A treat to myself when getting a PBJ smoothie. Fruit is fresh.', 'Placeholder from DC'),
];
