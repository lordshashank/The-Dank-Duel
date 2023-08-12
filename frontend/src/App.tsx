import React, { useEffect, useState } from "react";
import "./App.css";
import { Types, AptosClient } from "aptos";

const gameAddress =
  "0xf95cbc900b2f4bf53d915054218e6f7179e75c4426f93c4b7739600cda128096";

function App() {
  // Retrieve aptos.account on initial render and store it.
  const [address, setAddress] = useState<string | null>(null);
  const [publicKey, setPublicKey] = useState<string | null>(null);
  const [tokenAmount, setTokenAmount] = useState<string>("0");
  const [cardName, setCardName] = useState<string>("");
  const [cardDescription, setCardDescription] = useState<string>("");

  /**
   *
   * init function
   */
  const init = async () => {
    // connect
    try {
      if (window && !window.martian) {
        console.log("Martian not found");
        return { aptos: [], sui: [] };
      }

      const data = await window.martian.connect();
      console.log(data);
      // const { result } = data;
      // console.log(result);
      const address = data.address;
      console.log(address);
      const publicKey = data.publicKey;
      console.log(publicKey);
      setAddress(address);
      setPublicKey(publicKey);
    } catch (e) {
      console.log(e);
    }
  };

  useEffect(() => {
    init();
  }, []);

  const mintToken = async (amount: string) => {
    const payload = {
      function: `${gameAddress}::game::mint_token`,
      type_arguments: [],
      arguments: [amount],
    };
    console.log(payload);

    const result = await window.martian.generateSignAndSubmitTransaction(
      address,
      payload
    );
    console.log(result);
  };

  const mintCard = async (name: string, description: string) => {
    const payload = {
      function: `${gameAddress}::game::mint_card`,
      type_arguments: [],
      arguments: [name, description],
    };
    console.log(payload);

    const result = await window.martian.generateSignAndSubmitTransaction(
      address,
      payload
    );
    console.log(result);
  };

  return (
    <div className="App">
      <p>
        Account Address: <code>{address}</code>
      </p>
      <p>
        Account Public Key: <code>{publicKey}</code>
      </p>
      <input
        type="text"
        id="tokenAmount"
        placeholder="Token Amount"
        value={tokenAmount}
        onChange={(v) => setTokenAmount(v.target.value)}
      />
      <button onClick={() => mintToken(tokenAmount)}>
        {" "}
        Click to Mint Tokens!{" "}
      </button>
      <input
        type="text"
        id="cardName"
        placeholder="Card Name"
        value={cardName}
        onChange={(v) => setCardName(v.target.value)}
      />
      <input
        type="text"
        id="cardDescription"
        placeholder="Card Description"
        value={cardDescription}
        onChange={(v) => setCardDescription(v.target.value)}
      />
      <button onClick={() => mintCard(cardName, cardDescription)}>
        {" "}
        Click to Mint Card!{" "}
      </button>
    </div>
  );
}

export default App;
