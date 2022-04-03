# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Backend.Repo.insert!(%Backend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Backend.Repo.insert!(%Backend.Product{id: "amazon-prime", name: "Amazon Prime", price: 99.90})
Backend.Repo.insert!(%Backend.Product{id: "globo-play", name: "Globo Play", price: 25.99})
Backend.Repo.insert!(%Backend.Product{id: "hbo-max", name: "HBO Max", price: 85.99})
Backend.Repo.insert!(%Backend.Product{id: "netflix", name: "Netflix", price: 75.99})
Backend.Repo.insert!(%Backend.Product{id: "spotify", name: "Spotify", price: 55.99})
