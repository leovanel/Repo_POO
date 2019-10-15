<h2>1. Introduction</h2>
<p>Maintenant que tu as tous les outils de POO en main, on va te montrer comment les utiliser pour faire un petit jeu de combat du type Fortnite. Alors évidemment, je vais tout de suite calmer tes ardeurs : on va devoir se contenter de visuels bien moins ambitieux que le vrai jeu… Mais le principe sera là : des joueurs vont s'affronter dans une grande arène, s'échanger des coups, et tu ne pourras vaincre que si tu es le dernier debout ! 😎 </p>

<h2>2. Le projet</h2>
<p>On va faire ce projet de façon progressive : on va déjà produire une version 1.0 en te guidant, puis on passera à une version 2.0 un peu plus recherchée et moins guidée pour conclure sur une version 3.0 où on te donnera juste les directives !</p>
<p>C'est un projet relativement long et complet : l'objectif est a minima que tu puisses finir la version 1.0 pour valider le projet (il faut bien sûr qu'elle marche !). Mais on est persuadé qu'en vous aidant les uns les autres, vous arriverez à aller plus loin ! </p>

<h3>2.1. Mise en place du repo</h3>
<p>On commence toujours par préparer son espace de travail. Comme pour le projet d'hier, ouvre un dossier du genre <code>mini_jeu_POO</code> et donne-lui l'architecture suivante :</p>

<pre><code class="language-shell">mini_jeu_POO
├── lib
│   ├── player.rb
│   └── game.rb
├── app.rb
├── README.md
├── Gemfile
├── Gemfile.lock
└── Autres fichiers (.env, .gitignore)</code></pre>

<p>Dans le fichier <code>app.rb</code>, insère le code suivant : </p>

<pre><code class="language-ruby">require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

binding.pry</code></pre>

<p>Pour rappel, ces lignes vont te permettre d'exécuter ton programme proprement depuis <code>app.rb</code> en rendant toutes les gems disponibles dans tous les fichiers (2 premières lignes) et en faisant appel aux 2 autres fichiers présents dans <code>\lib</code> (les 2 lignes suivantes).</p>

<p>La ligne <code>binding.pry</code> est là pour te permettre de faire des tests. Tout ce que tu vas coder dans <code>player.rb</code>, tu pourras le tester dans le terminal (avec PRY) en exécutant directement un petit <code>ruby app.rb</code>.</p>

<h3>2.2. Version 1.0 : coder un combat entre 2 joueurs</h3>
<p>Quand on s'attaque à un gros morceau comme Fortnite, il y a un max de fonctionnalités qu'on peut avoir envie de coder. Alors pour ne pas se perdre, commençons par quelque chose qui soit à la fois <b>relativement simple à coder et central au jeu</b>. Ici, j'ai choisi de te faire commencer par un combat. Tout simplement. Si on est pas capable de coder un combat entre 2 personnages, on ne saura pas coder ce jeu : commençons donc par ça !</p>
<p>Que faut-il pour faire un combat ? Moi j'ai en tête qu'il faut a minima :</p>
<ul>
  <li>2 joueurs ;</li>
  <li>Que chaque joueur ait un niveau de vie donné ;</li>
  <li>Que ce niveau de vie baisse à chaque attaque subie ;</li>
  <li>Si la vie atteint zéro, le personnage est mort.</li>
</ul>

<p>Difficile de faire plus simple... Alors allons-y ! On va commencer par coder tout ça dans le fichier <code>player.rb</code> qui va donc accueillir la classe <code>Player</code> dont le but est de modéliser un joueur. Je vais te décrire chaque caractéristique d'un objet <code>Player</code>, charge à toi d'écrire le code !  </p>

<h4>a) <code>Player</code> : attributs et <code>initialize</code></h4>
<p>Un joueur possède 2 attributs que tu vas mettre en <code>attr_accessor</code> : un nom <code>@name</code> (string) et un niveau de vie <code>@life_points</code> (integer).</p>

<p>Quand on veut créer un objet <code>Player</code>, on ne met que son nom en entrée car le niveau de vie est le même pour tout le monde au début (10 pts de vie). Écris la méthode <code>initialize</code> afin qu'on ait la réaction suivante si on lance <code>app.rb</code> et qu'on utilise PRY :</p>
<pre><code class="language-bash">[1] pry(main)> player1 = Player.new("José")
=> #&lt;Player:0x000055e2ae15e910 @life_points=10, @name="José">
[2] pry(main)> player1.name
=> "José"
[3] pry(main)> player1.life_points
=> 10</code></pre>

<h4>b) <code>Player</code> : afficher l'état d'un joueur avec <code>show_state</code></h4>
<p>On sait que les joueurs vont se mettre sur la tronche et que donc leur niveau de vie va baisser. Donc on peut anticiper qu'il va falloir afficher à l'utilisateur l'état de chaque joueur pour qu'il sache ce qu'il se passe et comment le combat avance. Code une méthode <code>show_state</code> qui va afficher l'état de l'objet <code>Player</code> sur laquelle elle est exécutée : "XXXX a YYY points de vie".</p>

<p>Tout comme dans l'exemple ci-dessus, cette méthode doit permettre d'obtenir le résultat suivant si on lance <code>app.rb</code> et qu'on utilise PRY: </p>
<pre><code class="language-bash">[1] pry(main)> player1 = Player.new("José")
=> #&lt;Player:0x000055c8d3bcb960 @life_points=10, @name="José">
[2] pry(main)> player1.show_state
José a 10 points de vie
=> nil</code></pre>

<h4>c) <code>Player</code> : subir une attaque avec <code>gets_damage</code></h4>
<p>A ce stade, on a notre base pour définir un objet <code>Player</code>. Passons maintenant à une méthode indispensable pour un combat : celle qui fait baisser le niveau de vie du joueur. En gros je veux pouvoir modéliser "le joueur stocké dans l'objet <code>player1</code> subit 5 points de dommage" en faisant un <code>player1.gets_damage(5)</code>.</p>
<p>Tu dois coder une méthode <code>gets_damage</code> qui prend en entrée un integer (= le nombre de dommages subit) et qui le soustraie au niveau de vie (<code>@life_points</code>) du joueur.</p>
<p>Une fois la soustraction faite, la méthode vérifie si <code>@life_points</code> est inférieur ou égale à zéro. Si c'est le cas, c'est que le joueur est mort : elle affiche un message "le joueur XXXX a été tué !".</p>

<p>Voici le fonctionnement qu'on doit obtenir en exécutant <code>app.rb</code> et en utilisant PRY :</p>
<pre><code class="language-bash">[1] pry(main)> player1 = Player.new("José")
=> #&lt;Player:0x00005648d5f9ea88 @life_points=10, @name="José">
[2] pry(main)> player1.gets_damage(5)
=> nil
[3] pry(main)> player1.show_state
José a 5 points de vie
=> nil
[4] pry(main)> player1.gets_damage(5)
le joueur José a été tué !
=> nil
[5] pry(main)> player1.show_state
José a 0 points de vie
=> nil</code></pre>

<p>Petite aide : pour ceux qui sont COMPLEMENT perdus dans l'écriture de cette première méthode, son contenu est affiché ci-dessous en blanc sur blanc (surligne le texte avec ta souris pour l'afficher). <br>
⚠️ATTENTION⚠️ : si tu as besoin de cette aide pour avancer, c'est que le concept d'objet et l'écriture des classes n'est pas du tout clair pour toi (pour le moment). Il est INTERDIT de copier-coller cette méthode dans ton code : je veux que tu y jettes un œil puis que tu essayes, sans la recopier, de l'écrire à nouveau dans ton code. Tu dois comprendre chaque ligne. Ensuite, lance <code>app.rb</code> avec son <code>binding.pry</code> et fais plein de tests en créant 2 ou 3 objets <code>Player</code> différents, fais des <code>show_state</code> et des <code>gets_damage</code> dessus pour bien visualiser comment tout ça marche. <br>
Il n'y aura pas d'autre aide donc c'est important que tu saisisses MAINTENANT la logique. Quitte à te la faire expliquer par un co-moussaillon ! </p>

<p>-début de l'aide- <br>
<span style="color: white;">def gets_damage(damage_received) #damage_received est un entier qu'on met en entrée de la méthode<br>
<br>
    #On soustrait l'entier en entrée au niveau de vie de l'objet sur lequel la méthode est appliquée :<br>
    @life_points = @life_points - damage_received <br>
<br>
<br>
    #Si le niveau de vie de l'objet est inférieur ou égal à zéro, le joueur est tué et on affiche un message.<br>
    if @life_points <= 0<br>
      puts "le joueur #{@name} a été tué !" # l'écriture #{} permet d'insérer une variable dans un string<br>
    end<br>
  end<br>
<br>
end <br></span>
-fin de l'aide-</p>

<h4>d) <code>Player</code> : attaquer avec <code>attacks</code></h4>
<p>On est à présent capable de faire baisser les points de vie d'un joueur avec <code>gets_damage</code>. Il est temps de coder une méthode <code>attacks</code> qui permette de faire qu'un joueur attaque un autre. Ainsi, si le joueur <code>player1</code> attaque le joueur <code>player2</code>, on aurait juste à taper <code>player1.attacks(player2)</code>.</p>

<p>Code cette méthode en respectant ces contraintes :</p>
<ul>
  <li>La méthode prend donc en entrée un objet <code>Player</code> qui est le joueur subissant l'attaque ;</li>
  <li>La méthode commence par annoncer "le joueur [nom de player1] attaque le joueur [nom de player2]" avec un <code>puts</code> ;</li>
  <li>Ensuite on doit calculer les dommages que <code>player1</code> va faire subir à <code>player2</code>. Pour des raisons que tu comprendras plus tard, on va créer une méthode à part s'appelant <code>compute_damage</code> qui va faire ce calcul. Et dans la pure tradition des jeux de rôle, les dommages seront aléatoires car égaux au résultat d'un lancé de dé (= un chiffre au hasard entre 1 et 6). Voici le code de notre méthode <code>compute_damage</code> que tu vas mettre juste à la suite de <code>attacks</code> :</li>
<pre><code class="language-ruby">  def compute_damage
    return rand(1..6)
  end</code></pre>

  <li>Maintenant, dans <code>attacks</code>, fais appel à <code>compute_damage</code> et stocke le résultat dans une variable.</li>
  <li>Fais subir les dégâts à l'autre <code>Player</code> en utilisant ces dommages et la méthode <code>gets_damage</code>.</li>
  <li>À présent <code>puts</code> une phrase qui explique ce qui vient de se passer : "il lui inflige XXXX points de dommages"</li>
</ul>

<p>Voici le fonctionnement qu'on doit obtenir en exécutant <code>app.rb</code> et en utilisant PRY :</p>
<pre><code class="language-bash">[1] pry(main)> player1 = Player.new("Josiane")
=> #&lt;Player:0x000055ebac183358 @life_points=10, @name="Josiane">
[2] pry(main)> player2 = Player.new("José")
=> #&lt;Player:0x000055ebac11cb80 @life_points=10, @name="José">
[3] pry(main)> player1.attacks(player2)
Josiane attaque José
il lui inflige 5 points de dommages
=> nil
[4] pry(main)> player2.show_state
José a 5 points de vie
=> nil
[5] pry(main)> player1.show_state
Josiane a 10 points de vie
=> nil</code></pre>

<h4>e) Orchestrons un combat !</h4>
<p>C'est bon, on a tous les ingrédients pour que nos joueurs se trucident bien comme il faut ! Les joueurs peuvent attaquer, subir des dégâts et on peut donner des infos sur le terminal via plein de <code>puts</code>. Il ne nous reste qu'à mettre en place notre premier combat.</p>

<p>On va tout coder dans <code>app.rb</code> qui va orchestrer le combat et faire appel à la classe <code>Player</code>. Petite exception à la règle : pas besoin de créer une classe <code>App</code> dans ce fichier.<p>

<p>Je vais à nouveau te guider pas à pas. N'oublie pas de vérifier que chaque étape fonctionne bien en exécutant <code>app.rb</code> avec un petit <code>binding.pry</code> à la fin pour confirmer que tout marche avant de passer à l'étape d'après.</p>
<p> Allez c'est parti :</p>

<ol>
  <li><b>À ma droite "Josiane"</b> : crée un <code>Player</code> répondant à ce doux prénom et stocké dans la variable <code>player1</code>.</li>
  <li><b>À ma gauche "José"</b> : crée un autre <code>Player</code> répondant à ce joli prénom et stocké dans la variable <code>player2</code>.</li>

  <li><b>Présentons les deux combattants</b> : affiche dans le terminal l'état de chaque combattant grâce à des <code>puts</code> et des <code>show_state</code>. Juste avant, affiche un petit <code>puts "Voici l'état de chaque joueur :"</code>.</li>
  <li><b>Fight !</b> Indique que le combat commence avec un <code> puts "Passons à la phase d'attaque :"</code>.</li>
  <li><b>Josiane aura l'honneur d'attaquer la première</b> : fais attaquer <code>player2</code> par <code>player1</code> avec la méthode <code>attacks</code>.</li>
  <li><b>José ne va pas se laisser faire</b> : fais l'attaque inverse.</li>
</ol>

<p>Si tu exécutes le code en l'état, tu devrais avoir un premier round d'attaque entre nos deux gladiateurs. C'est déjà un bon début ! Mais José et Josiane doivent à présent combattre jusqu'à la mort 👎. Ils doivent donc s'attaquer jusqu'à ce que l'un des deux n'ait plus de point de vie. Es-tu déjà en mesure de voir comment faire ?</p>

<p>Allez, sur cette première étape je t'aide : il faut faire une boucle <code>while</code>. En effet, on ne sait pas combien de tours le combat va durer vu que les dommages sont aléatoires (il faut entre 2 et 10 coups pour venir à bout des 10 points de vie).</p>

<p>Tu vas donc créer une boucle qui commence au point 3 de la liste ci-dessus (la présentation de l'état de chaque combattant doit avoir lieu au début de la boucle) et finie au point 6. Cette boucle doit tourner jusqu'à ce qu'un des <code>Player</code> voit son niveau de vie être inférieur ou égal à zéro. Es-tu en mesure d'écrire cette condition d'arrêt ?</p>

<p>Aide si tu n'y arrives pas (surligne le texte ci-après, en blanc sur blanc) : <span style="color: white;">while player1.life_points > 0 && player2.life_points >0</span> - fin de l'aide -</p>

<p>Et voilà tu dois maintenant pouvoir faire tourner plusieurs combats sans souci et faire des paris sur qui, de José ou Josiane, en sortira les pieds devants. Hum… En fait si tu fais tourner plusieurs combats, tu devrais identifier un petit souci.</p>

<h4>f) Corrigeons ce petit bug</h4>
<p>Et oui, si jamais José (<code>player2</code>) venait à être tué en premier, tu vas vite te rendre compte qu'il peut malgré tout porter une dernière attaque sur Josiane (et potentiellement la tuer aussi). Pas terrible : ça serait considéré comme un bug par un utilisateur extérieur ! On doit gérer ce cas.</p>

<p>Juste après l'attaque de Josiane (<code>player1</code>) sur José (<code>player2</code>), rajoute un petit <code>if</code> qui teste si <code>player2</code> est mort (ses points de vie sont négatifs ou nuls). Si c'est le cas, il nous faut sortir immédiatement de la boucle <code>while</code> : c'est faisable grâce à la ligne <code>break</code>.</p>

<h4>Résultat attendu sur le terminal</h4>

<p>Voici un exemple de ce que le terminal doit afficher si tu lances un combat en exécutant <code>app.rb</code> :</p>
<pre><code class="language-bash">Voici l'état de nos joueurs :
Josiane a 10 points de vie
José a 10 points de vie

Passons à la phase d'attaque :
Josiane attaque José
il lui inflige 4 points de dommages
José attaque Josiane
il lui inflige 3 points de dommages

Voici l'état de nos joueurs :
Josiane a 7 points de vie
José a 6 points de vie

Passons à la phase d'attaque :
Josiane attaque José
il lui inflige 1 points de dommages
José attaque Josiane
il lui inflige 4 points de dommages

Voici l'état de nos joueurs :
Josiane a 3 points de vie
José a 5 points de vie

Passons à la phase d'attaque :
Josiane attaque José
il lui inflige 1 points de dommages
José attaque Josiane
il lui inflige 6 points de dommages
le joueur Josiane a été tué !</code></pre>

<p>Comme tu peux le voir, j'ai inséré quelques sauts de ligne en plus pour rendre le tout plus lisible. N'hésite pas à mettre en page un peu mieux si tu te sens de rajouter des <code>puts</code> en plus, des lignes de "------------" ou autres.</p>

<h3>2.3. Version 2.0 : créer un nouveau type de joueur</h3>
<p>Nous allons maintenant créer un nouveau type de joueur qui va disposer de plus de compétences et de plus de choix : il sera joué par un humain. Je vais un peu moins t'accompagner dans cette version-là afin de te laisser te creuser la tête et t'obliger à chercher les solutions sur internet ou parmi la communauté.</p>

<h4>a) Poser les bases de la nouvelle classe</h4>
<p>Commence par compléter ton fichier <code>player.rb</code> en rajoutant, à la suite de la classe <code>Player</code>, une nouvelle classe que nous appellerons <code>HumanPlayer</code>. Les bonnes pratiques en Ruby voudraient qu'on découpe cela en 2 fichiers différents mais ici, on va faire simple et efficace car ce programme est relativement petit.</p>
<p>Cette classe doit hériter de <code>Player</code> car nous voulons qu'un objet <code>HumanPlayer</code> ait la même base : les attributs <code>name</code> et <code>life_points</code> ainsi que toutes les méthodes que nous avons codées.</p>

<h4>b) <code>HumanPlayer</code> : l'attribut <code>@weapon_level</code> et modification de <code>initialize</code> et <code>show_state</code></h4>
<p>Il y aura 2 choses qui vont différencier un <code>HumanPlayer</code> d'un <code>Player</code>. Tout d'abord, on va donner un petit avantage à notre joueur humain vis-à-vis des bots : il disposera de 100 points de vie. Ensuite, il aura la possibilité d'améliorer l'arme dont il dispose pour augmenter les dégâts qu'il inflige à ses adversaires.</p>

<p>Commence par définir en <code>attr_accessor</code> la variable <code>weapon_level</code> qui définira, sous forme d'integer, le niveau de l'arme du <code>HumanPlayer</code>.</p>

<p>Maintenant tu vas définir une nouvelle méthode <code>initialize</code> qui prend toujours uniquement le <code>name</code> en entrée mais, à la différence de celle des <code>Player</code> :</p>
<ul>
  <li>Elle donne une valeur de 100 à <code>@life_points</code>.</li>
  <li>Elle fixe <code>@weapon_level = 1</code>.</li>
</ul>

<p>Et vu qu'on modifie la nature de cet objet, autant modifier la façon de présenter le joueur. Tu vas changer la méthode <code>show_state</code> afin qu'elle affiche une phrase du genre "XXX a YYY points de vie et une arme de niveau ZZZ".</p>

<h4>c) <code>HumanPlayer</code> : augmenter les dommages causés</h4>
<p>C'est cool que les <code>HumanPlayer</code> aient une arme avec un <code>@weapon_level</code>, mais il faut que ça serve en combat ! On va faire de <code>@weapon_level</code> un multiplicateur des dégâts. Tu vas créer, dans <code>HumanPlayer</code>, une nouvelle méthode <code>compute_damage</code> pour refléter cela : </p>

<pre><code class="language-ruby">def compute_damage
    rand(1..6) * @weapon_level
  end</code></pre>

<p>Du coup tu comprends mieux pourquoi, dans la classe <code>Player</code>, je t'avais fait créer une méthode <code>compute_damage</code> toute seule. C'était pour anticiper le fait que la ligne <code>rand(1..6)</code> allait devoir prendre en compte l'existence d'un <code>@weapon_level</code> dans la classe <code>HumanPlayer</code>. Grâce à ça, on a juste à modifier la méthode très courte <code>compute_damage</code> et non pas la méthode <code>attacks</code> entière.</p>

<p>Si tu suis bien, une fois que tu as fait ce travail, les joueurs de type <code>Player</code> pourront infliger des dégâts compris entre 1 et 6 alors que les joueurs de type <code>HumanPlayer</code> infligeront des dégâts compris entre [@weapon_level] et [6 x @weapon_level].</p>

<h4>d) <code>HumanPlayer</code> : chercher une nouvelle arme</h4>
<p>Une nouvelle fonctionnalité spécifique aux <code>HumanPlayer</code> sera la possibilité pour lui d'aller chercher une nouvelle arme, plus puissante. Pour cela, tu vas coder, dans la classe <code>HumanPlayer</code>, une méthode <code>search_weapon</code> qui va faire les choses suivantes :</p>

<ul>
  <li>Elle va commencer par lancer un "dé" dont le résultat sera compris entre 1 et 6 (tu sais faire ça maintenant non?).</li>
  <li>Ce lancé de dé sera égal au niveau de la nouvelle arme trouvée. Annonce le résultat de la recherche à l'utilisateur en affichant un message du genre "Tu as trouvé une arme de niveau XXX".</li>
  <li>Maintenant, cherche à savoir si ça vaut le coup pour le joueur <code>Human Player</code> de la garder… Utilise un <code>if</code> pour comparer le niveau de cette nouvelle arme avec celle qu'il possède déjà (<code>@weapon_level</code>).</li>
  <li>Si l'arme trouvée est d'un niveau strictement supérieur, il la garde. Son <code>@weapon_level</code> prend alors la valeur de la nouvelle arme et tu affiches un message du genre "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."</li>
  <li>Si l'arme trouvée est égale ou moins bien que son arme actuelle, tu ne changes rien et ne fais qu'afficher un petit "M@\*#$... elle n'est pas mieux que ton arme actuelle..."</li>
</ul>

<h4>e) <code>HumanPlayer</code> : chercher un pack de points de vie</h4>
<p>Une autre fonctionnalité qu'auront les <code>HumanPlayer</code> : ils pourront partir à la recherche d'un pack de points de vie afin de faire remonter leur niveau de vie. De façon assez similaire à la méthode <code>search_weapon</code>, tu vas coder une méthode <code>search_health_pack</code> qui va se comporter comme suit :</p>

<ul>
  <li>Elle commence également par lancer un "dé" dont le résultat sera compris entre 1 et 6. En fonction du résultat, voilà ce qu'elle devra faire :</li>
  <li>Si le résultat est égal à 1, le joueur n'a rien trouvé et on retourne simplement le string "Tu n'as rien trouvé... ".</li>
  <li>Si le résultat est compris entre 2 (inclus) et 5 (inclus), le joueur a trouvé un pack de 50 points de vie. On va donc augmenter sa vie de 50 points mais sans qu'elle puisse dépasser 100 points. Puis on va retourner le string "Bravo, tu as trouvé un pack de +50 points de vie !".</li>
  <li>Si le résultat est égal à 6, le joueur a trouvé un pack de 80 points de vie. On va donc augmenter sa vie de 80 points mais sans qu'elle puisse dépasser 100 points. Puis on va retourner le string "Waow, tu as trouvé un pack de +80 points de vie !".</li>
</ul>

<h4>f) Combat interactif sur <code>app_2.rb</code> : toi contre José et Josiane</h4>
<p>OK, tous les ingrédients sont prêts: il ne nous reste plus qu'à mettre le tout en musique pour enfin jouer ton premier interactif ! Cela va se faire au tour-par-tour et à chaque fois tu auras le choix entre plusieurs actions afin de te défaire de tes 2 adversaires.</p>
<p>Le fichier qui va orchestrer tout cela va s'appeler <code>app_2.rb</code> afin que tu gardes intacte ta version 1.0 sur <code>app.rb</code>. Commence donc par créer ce fichier (toujours à la racine de ton dossier) et fais-le commencer par les mêmes 4 lignes de code que ton <code>app.rb</code> de base : </p>

<pre><code class="language-ruby">require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'</code></pre>

<p>Maintenant, voici la liste de ce que tu dois coder dans <code>app_2.rb</code>. Fais-le au fur et à mesure, et ne passe à l'étape suivante que si ton code marche :</p>

<ul>
  <li><b>Accueil</b> : Commence par afficher dans le terminal, au lancement de <code>app_2.rb</code>, un petit message de démarrage du jeu. Laisse libre cours à ton imagination mais voici un exemple basique :</li>
<pre><code class="language-bash">------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------</code></pre>
  <li><b>Initialisation du joueur</b>: ensuite, le jeu va demander à l'utilisateur son prénom et créer un <code>HumanPlayer</code> portant ce prénom.</li>
  <li><b>Initialisation des ennemis</b> : le jeu va maintenant créer nos deux combattants préférés, "Josiane" et "José". <br>
  Comme nous savons qu'à terme (version 3.0) il y aura plus de 2 ennemis, on va mettre en place une astuce pour manipuler facilement un groupe d'ennemis : le jeu va créer un array <code>enemies</code> qui va contenir les deux objets <code>Player</code> que sont José et Josiane. Tu verras plus tard l'usage qu'on va en faire.</li>
  <li><b>Le combat</b> : tout comme dans la version 1.0, on peut maintenant lancer le combat ! Tu vas ouvrir une boucle <code>while</code> qui ne doit s'arrêter que si le joueur de l'utilisateur (<code>HumanPlayer</code>) meurt ou si les 2 joueurs "bots" (<code>Player</code>) meurent. Cette condition d'arrêt n'est pas triviale à écrire mais je te propose d'essayer ! Sinon la réponse est disponible plus bas. Laisse la boucle <code>while</code> vide pour le moment, on la codera juste après.</li>
  <li><b>Fin du jeu</b> : maintenant, si on sort de cette boucle <code>while</code>, c'est que la partie est terminée. Donc juste en dessous du <code>end</code> de la boucle, on va préparer un petit message de fin. Le jeu doit afficher "La partie est finie" et ensuite soit afficher "BRAVO ! TU AS GAGNE !" si le joueur humain est toujours en vie, ou "Loser ! Tu as perdu !" s'il est mort.</li>
</ul>

<p>Très bien, on a l'ossature globale du jeu version 2.0 mais il reste à coder le combat ! Voici ce que tu vas mettre dans la boucle <code>while</code> :</p>

<ul>
  <li>Tout d'abord, on te donne la condition d'arrêt de la boucle en partant de l'hypothèse que tu as stocké le <code>HumanPlayer</code> dans la variable <code>user</code> et les deux <code>Player</code> dans les variables <code>player1</code> et <code>player2</code>.</li>
<pre><code class="language-ruby">while user.life_points >0 && (player1.life_points > 0 || player2.life_points >0)
  ...
end</code></pre>
  <li>La première chose qu'on va faire à chaque tour de combat, c'est afficher l'état du <code>HumanPlayer</code> : rajoute cela.</li>
  <li>Ensuite, on va proposer un menu qui doit ressembler à cela :</li>

<pre><code class="language-bash">Quelle action veux-tu effectuer ?

a - chercher une meilleure arme
s - chercher à se soigner

attaquer un joueur en vue :
0 - Josiane a 10 points de vie
1 - José a 10 points de vie</code></pre>
  <li>Évidemment la partie "Josiane a 10 points de vie" et "José a 10 points de vie" devra se mettre à jour quand ils vont recevoir des dégâts. Tu dois donc utiliser la méthode <code>show_state</code> dans cette partie du menu pour afficher l'état réel de chaque <code>Player</code> que l'utilisateur combat.</li>
  <li>Une fois cela fait, on laisse l'utilisateur effectuer une saisie. Et en fonction de la saisie, on va :</li>
  <ul>
    <li>si l'utilisateur tape "a", exécuter sur son  <code>HumanPlayer</code> la méthode qui le fait partir à la recherche d'une arme ;</li>
    <li>si l'utilisateur tape "s", exécuter sur son  <code>HumanPlayer</code> la méthode qui le fait partir à la recherche d'un pack de soin ;</li>
    <li>si l'utilisateur tape "0", faire attaquer Josiane par son <code>Human Player</code> ;</li>
    <li>si l'utilisateur tape "1", faire attaquer José par son <code>Human Player</code> ;</li>
  </ul>
  <li>C'est maintenant au tour des ennemis de riposter ! Tu peux l'indiquer en affichant en console un petit <code>puts "Les autres joueurs t'attaquent !"</code></li>
  <li>On va faire que les 2 <code>Player</code> attaquent le <code>HumanPlayer</code>. Mais au lieu d'écrire 2 lignes quasiment identiques en mode <code>player1.attacks(user)</code> et <code>player2.attacks(user)</code>, je veux que tu utilises l'array <code>enemies</code> contenant les 2 objets <code>Player</code>. L'idée est de faire une boucle <code>each</code> sur cet array pour ensuite exécuter la méthode <code>attacks</code> sur chaque objet. Pourquoi ? Tout simplement car on anticipe là le fait qu'il y aura bientôt 10 ou 20 ou 30 <code>Player</code> : on va pas se taper 10 ou 20 ou 30 lignes de <code>playerX.attacks(user)</code> !  </li>
  <li>Ha oui, un petit dernier truc : il ne faut pas qu'un <code>Player</code> puisse attaquer s'il est mort… Donc rajoute un petit <code>if</code> dans ta boucle <code>each</code>.</li>
</ul>

<p>Super ! Tu es arrivé au bout de la version 2.0 de ton Fornite-like ! Lance plusieurs combats, fais plein de tests et compare les résultats avec tes fellow moussaillons. N'hésite pas à mettre des petits <code>gets.chomp</code> ici et là qui auront pour seul objectif de faire une petite pause dans l'affichage du texte du jeu sur le terminal. Ça aidera à la lecture et à suivre ce qu'il se passe.</p>


<h3>2.4. Version 3.0 : un jeu mieux organisé et plus d'ennemis</h3>
<p>Bravo, tu as fini la version 2.0 ! Si tout est fait proprement jusque là, tu valides sans souci le projet. Maintenant, on va augmenter un peu le niveau car tu as besoin de challenge. Fini le pas à pas : on va te donner des instructions plus générales, charge à toi de t'en sortir seul !</p>
<p>Commence par créer un fichier <code>app_3.rb</code> pour garder l'historique de tes versions 1.0 et 2.0. Ce fichier doit commencer avec les mêmes 4 lignes de <code>require</code> que les 2 autres.</p>

<h4>a) Première étape : rapatrier plein de choses de <code>app_2.rb</code> vers une nouvelle classe <code>Game</code></h4>
<p>Notre fichier <code>app_2.rb</code> gère beaucoup trop de chose et il est trop long pour que ce soit acceptable : on doit ranger son contenu dans des méthodes et des classes dédiées. On va donc créer une classe <code>Game</code> dans le fichier <code>game.rb</code> qui aura pour rôle de stocker les informations du jeu et effectuer chaque étape.</p>

<p>Voici ce que tu dois faire dans la classe <code>Game</code> (80 % du travail consiste à rapatrier du code depuis <code>app_2.rb</code>) :</p>

<ul>
  <li>Crée la classe <code>Game</code> qui aura 2 <code>attr_accessor</code> : un <code>@human_player</code> de type <code>HumanPlayer</code> et un array <code>@enemies</code> qui contiendra des <code>Player</code>.</li>
  <li>Un objet <code>Game</code> s'initialise ainsi : <code>my_game = Game.new("Wolverine")</code>. Il crée automatiquement 4 <code>Player</code> qu'il met dans <code>@enemies</code> et un <code>HumanPlayer</code> portant (dans cet exemple) le nom "Wolverine".</li>
  <li>Écris une méthode <code>kill_player</code> qui prend un objet <code>Player</code> en entrée et le supprime de <code>@enemies</code>. Cette méthode permet d'éliminer un adversaire tué.</li>
  <li>Écris une méthode <code>is_still_ongoing?</code> qui retourne true si le jeu est toujours en cours et false sinon. Le jeu continue tant que le <code>@human_player</code> a encore des points de vie et qu'il reste des <code>Player</code> à combattre dans l’array <code>@enemies</code>.</li>
  <li>Écris une méthode <code>show_players</code> qui va afficher 1) l'état du joueur humain et 2) le nombre de joueurs "bots" restant</li>
  <li>Écris une méthode <code>menu</code> qui va afficher le menu de choix (juste l'afficher, pas plus). On a les mêmes choix que dans la version 2.0 à la seule différence qu'il y a plus de 2 ennemis à combattre et que si un ennemi est mort, on ne doit plus proposer de l'attaquer.</li>
  <li>Écris une méthode <code>menu_choice</code> qui prend en entrée un string. Cette méthode va permettre de faire réagir le jeu en fonction du choix, dans le menu, de l'utilisateur. Par exemple, si l'entrée est "a", le <code>@human_player</code> doit aller chercher une arme. Si l'entrée est "0", on le fait attaquer l'ennemi présenté au choix "0", etc. Pense à faire appel, dans cette méthode, à la méthode <code>kill_player</code> si jamais un <code>Player</code> est tué par le joueur humain !</li>
  <li>Écris une méthode <code>enemies_attack</code> qui va faire riposter tous les ennemis vivants. Ils vont attaquer à tour de rôle le joueur humain.</li>
  <li>Écris une méthode <code>end</code> qui va effectuer l'affichage de fin de jeu. Tu sais, la partie "le jeu est fini" puis "Bravo..." ou "Loser..."</li>
</ul>

<h4>b) <code>app_3.rb</code> en chef d'orchestre</h4>
<p>Maintenant tu vas compléter <code>app_3.rb</code> pour qu'il puisse coordonner le jeu.</p>

<p>Fais commencer le jeu par l'habituel message de bienvenue, demande son nom à l'utilisateur et utilise-le pour initialiser un objet <code>Game</code> que tu vas stocker dans une variable <code>my_game</code> et rappeler tout du long de ton code.</p>
<p>Inspire-toi du contenu de <code>app_2.rb</code> mais cette fois-ci, tu ne dois faire que des appels de méthode sur ton objet <code>my_game</code>. Il contient toute l'information du jeu en cours : le personnage de ton utilisateur et ses ennemis. Par contre tu peux mettre les <code>gets.chomp</code> directement dans le code de <code>app_3.rb</code></p>

<h4>c) Quelques fonctionnalités en plus</h4>
<p>On aimerait bien que notre Fornite-like permette de combattre 10 ou 20 ennemis sur une même partie... Mais s'ils débarquent tous dès le début et s'acharnent sur notre pauvre <code>HumanPlayer</code>, même avec ses habilités spéciales il va pas durer longtemps.</p>
<p>On va mettre en place un système où les ennemies vont débarquer au compte-goutte, un peu comme dans les jeux où on tombe sur eux au hasard de tes déplacements sur la carte. Pour ça, on va suivre à la fois le nombre d'ennemis toujours présents dans le jeu ( = ennemis restant à éliminer) et le nombre d'ennemis qui sont "en vue" (= ennemis qu'on peut attaquer et qui peuvent nous attaquer en retour). Voilà comment on va faire dans la classe <code>Game</code> :</p>

<ul>
  <li>Rajoute deux attributs : <code>@players_left</code> qui est un integer qu'on initialize à 10 et <code>@enemies_in_sight</code> qui vient remplacer <code>@enemies</code> et qui est un array vide au départ. Tu l'as compris car j'ai bien nommé mes variables (prends en de la graine) : <code>@players_left</code> représente le nombre de joueur restant dans le jeu (= nombre restant à éliminer pour gagner) et <code>@enemies_in_sight</code> est un array de <code>Player</code> qui sont ceux en vue (= qu'on peut attaquer et qui vont nosu attaquer en retour).</li>
  <li>Modifie la méthode <code>is_still_ongoing?</code> pour que le jeu continue tant que notre <code>HumanPlayer</code> est toujours en vie et qu'il n'est pas le dernier vivant.</li>
  <li>Crée une méthode <code>new_players_in_sight</code> qui va avoir pour rôle de rajouter des ennemis en vue. Voici les règles de fonctionnement de cette méthode :</li>
  <ul>
    <li>Si tous les joueurs du jeu sont déjà "en vue", on ne doit pas en rajouter. Dans ce cas, cela signifie que le nombre d'objets <code>Player</code> dans <code>@enemies_in_sight</code> est égal à l'integer <code>@players_left</code>. Affiche alors un message d'info du type "Tous les joueurs sont déjà en vue".</li>
    <li>La méthode va lancer un dé à 6 faces et va réagir en fonction de ce résultat aléatoire :</li>
    <li>Si le dé vaut 1, aucun nouveau joueur adverse n'arrive (afficher un message informant l'utilisateur).</li>
    <li>Si le dé vaut entre 2 et 4 inclus, un nouvel adversaire arrive en vue. Il faut alors créer un <code>Player</code> avec un nom aléatoire du genre "joueur_1234" ou "joueur_6938" (ou ce que tu veux) et injecter ce <code>Player</code> dans le array <code>@enemies_in_sight</code> . Affiche un message informant l'utilisateur de ce qui se passe.</li>
    <li>Si le dé vaut 5 ou 6, cette fois c'est 2 nouveaux adversaires qui arrivent en vue. De même qu'au-dessus, il faut les créer et les rajouter au jeu. Rajoute toujours un message informant l'utilisateur.</li>
  </ul>
  <li>Et maintenant, il faut que cette méthode <code>new_players_in_sight</code> soit appelée dans ton <code>app_3.rb</code> juste avant l'affichage du menu à l'utilisateur. Cela permet d'ajouter, petit à petit, des adversaires en vue !</li>
</ul>

<p>Voilà, une fois que tu auras fait ça, tu pourras essayer de sortir vivant d'un combat contre 10, 20 voire 100 adversaires ! N'hésite pas à pimper l'affichage pour l'utilisateur et à joueur sur les paramètres (la vie de chaque adversaire, ta vie, la taille des packs de vie qu'on peut trouver, etc.) pour trouver les réglages qui sont les plus fun !</p>



<h2>3. Rendu attendu</h2>
<p>Un repo GitHub contenant l'ensemble de ton programme qui a l'architecture dossier décrite en 2.1</p>
<p>Le repo doit contenir chaque version de ton jeu en fonction de ce que tu auras réussi à faire : <code>app.rb</code>, <code>app_2.rb</code> et <code>app_3.rb</code>. En effet, on va demander à tes correcteurs de tester chaque version.</p>
