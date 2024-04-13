BRANDS = ["Delta Plus", "Carhartt", "Stedman", "Under Armour", "Gap", "Rusty", "Slick", "Neo Tools"]
COLORS = ["Червоний", "Синій", "Зелений", "Жовтий", "Чорний", "Білий", "Сірий"]

BRANDS.each do |brand|
  Brand.create(title: brand, en_title: )
end

COLORS.each do |color|
  Color.create(title: color)
end

ActiveRecord::Base.transaction do
  worker_category = Category.create(title: "Робочий одяг")
  coats = worker_category.subcategories.create(title: "Куртки")
  jilets = worker_category.subcategories.create(title: "Жилети")
  shorts = worker_category.subcategories.create(title: "Шорти")
  jeans = worker_category.subcategories.create(title: "Штани")
  costumes = worker_category.subcategories.create(title: "Костюми")

  half_comb = Wear.create(
    name: "Напівкомбінезон",
    description: "Практичний і функційний робочий одяг для півночі, призначений для професійної діяльності й побуту. Можна використовувати як окремий елемент спорядження, а також у комплекті з утепленим спецодягом для роботи просто неба й у приміщеннях.",
    price: Faker::Commerce.price(range: 1000..1300.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_combinezone.webp"
  )

  half_comb.subcategory = costumes

  coat = Wear.create(
    name: "Куртка",
    description: "Використовують як окремий елемент робочого спорядження та в комплекті із зимовою курткою для роботи за низької температури просто неба й у прохолодних приміщеннях.
    Модель має сучасний фасон, презентабельний і охайний вигляд, тому підходить для фахівців ІТП — як керівників, так і працівників, діяльність яких пов'язана з будівництвом, проєктуванням, інженерними системами, монтажними роботами тощо. Знадобиться у всіх галузях економіки.",
    price: Faker::Commerce.price(range: 1000..1300.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_shirt.webp"
  )

  coat.subcategory = coats

  halat = Wear.create(
    name: "Халат",
    description: "Категорія спеціалізованого одягу для професійної діяльності, рекомендована для захисту від негативних зовнішніх чинників, що виникають під час робочого процесу.
    Презентабельний вигляд, функційність і практичність моделі відмінно підходять для працівників інженерно-технічних підрозділів підприємств: біохіміків, агрономів, ветеринарних лікарів та зоотехніків, гідротехніків, лаборантів, інженерів, конструкторів, контролерів й інших професій.",
    price: Faker::Commerce.price(range: 800..1200.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_coat.webp"
  )

  halat.subcategory = costumes

  shorts_worker = Wear.create(
    name: "Шорти",
    description: "Багатофункціональні та місткі кишені, комфортна панель в промежині, шкіряні бирки з логотипом, внутрішня бирка з іменем, унікальний індивідуальний дизайн, сертифікований CE за стандартом EN ISO 13688:2013.",
    price: Faker::Commerce.price(range: 800..1200.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_shorts.webp"
  )

  shorts_worker.subcategory = shorts

  costume = Wear.create(
    name: "Костюм",
    description: "Практичний і комфортний робочий спецодяг, який використовують для захисту від загальних виробничих забруднень та механічних впливів. Знадобиться для роботи надворі та в приміщеннях у теплу пору року, але можна використовувати в поєднанні з утепленим одягом за низької температури.
    Спеціалізований одяг цієї моделі підходить для персоналу інженерно-технічного підрозділу підприємств: проєктувальників, техніків, інженерів, конструкторів, кошторисників, обліковців, а також виконробів, майстрів і бригадирів.",
    price: Faker::Commerce.price(range: 800..1200.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_costume.webp"
  )

  costume.subcategory = costumes

  coat_signal = Wear.create(
    name: "Куртка сигнальна з капюшоном",
    description: "Світловідбивні ремені, що відповідають нормі EN ISO 20471 у поєднанні з сигнальним матеріалом, забезпечують найвищий клас видимості: клас 2;
    3 кишені, що застібаються на замок, Вітрозахисні блискавки, Регулювання ширини блузи внизу за допомогою двосторонньої куліски з фіксатором, що затягується.",
    price: Faker::Commerce.price(range: 800..1200.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_jacket_with_hood_lightreflective.webp"
  )

  coat_signal.subcategory = coats

  worker_coat_hood = Wear.create(
    name: "Куртка робоча",
    description: "Подвійні шви;
    Застібка-блискавка;
    Кришка золотника;
    Світловідбивні вставки, що підвищують безпеку під час роботи;
    Низ куртки регулюється за допомогою липучок;
    Рукави з товстою гумкою;
    Практичний капюшон із регулюванням ширини;
    Модний та цікавий дизайн",
    price: Faker::Commerce.price(range: 1800..2200.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_jacket_with_hood.webp"
  )

  worker_coat_hood.subcategory = coats

  jacket = Wear.create(
    name: "Куртка робоча флісова",
    description: "Подвійні шви;
    Застібка-блискавка;
    Кришка золотника;
    Світловідбивні вставки, що підвищують безпеку під час роботи;
    Низ куртки регулюється за допомогою липучок;
    Рукави з товстою гумкою;
    Практичний капюшон із регулюванням ширини;
    Модний та цікавий дизайн",
    price: Faker::Commerce.price(range: 2800..3000.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_jacket_with_neck_fleece.webp"
  )

  jacket.subcategory = coats

  jilet_signal = Wear.create(
    name: "Жилет робочий сигнальний",
    description: "практична й багатофункціональна річ, головне завдання якої полягає у візуальному позначенні працівника вдень завдяки яскравому кольорові й у темряві — завдяки світловідбивній поверхні виробу. Можна використовувати в комплекті з демісезонним і зимовим спецодягом, зокрема поверх утепленої робочої куртки.
    Актуальна модель сигнального жилета в таких сферах діяльності, як будівництво доріг, дорожньо-комунальне господарство, будівництво, транспорт, склад тощо.",
    price: Faker::Commerce.price(range: 1000..1500.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_jacket_yellow.webp"
  )

  jilet_signal.subcategory = jilets

  jeans_worker = Wear.create(
    name: "Штани робочі",
    description: "Практичний робочий одяг для півночі, який використовують для захисту від загального виробничого забруднення й механічних пошкоджень. Модель універсальна, належить до категорії професійного демісезонного спецодягу, її можна використовувати влітку або в комплекті з утепленим спецодягом для роботи надворі та в закритих приміщеннях.
    Сфера застосування широка: промисловість, виробництво, будівництво, зокрема будівництво й ремонт доріг, різні галузі народного господарства, транспорт, складська логістика. Актуально для інженерно-технічного персоналу, служб доставки, вантажоперевезення, охоронних підприємств та інших професій.",
    price: Faker::Commerce.price(range: 800..1200.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_jeans.webp"
  )

  jeans_worker.subcategory = jeans

  jilet_worker = Wear.create(
    name: "Жилет робочий",
    description: "Блискавку жилета захищає від пошкоджень накладка на кнопках. Нагрудні кишені на липучках. Дві нижні кишеніпрорізного типу великої місткості. Жилет має невисокий комір типу «стійка» та бокові регулятори ширинина кнопках. Виїмки для рукавів широкі, дають змогу вдягати під жилет щільні светри й сорочки.  ",
    price: Faker::Commerce.price(range: 800..1200.0),
    brand: Brand.all.sample,
    color: Color.all.sample,
    sex: rand(0..1),
    image_name: "wears/worker_jilet.webp"
  )

  jilet_worker.subcategory = jilets
end
