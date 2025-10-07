tolk 1.1

struct Map {
    text: string;
    created: uint32;
}

struct Storage {
    maps: map<address, Map>;
    description: string; // English description
}

fun Storage.load() = Storage.fromCell(contract.getData());
fun Storage.save(self) = contract.setData(self.toCell());

fun add(text: string) {
    var st = Storage.load();
    let caller = get_caller();

    st.maps.set(caller, Map{text: text, created: blockchain.now()});
    st.description = "This contract stores user in a map, causing storage to grow indefinitely.";
    st.save();
}
