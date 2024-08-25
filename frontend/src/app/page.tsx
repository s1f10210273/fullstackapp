"use client";

import { useState, useEffect } from "react";
import { getHello } from "@/libs/api";

export default function HomePage() {
  const [hello, setHello] = useState<string | null>(null);

  useEffect(() => {
    const fetchHello = async () => {
      try {
        const data = await getHello();
        setHello(data.message);
      } catch (error) {
        console.error("Error fetching hello:", error);
        setHello("Error fetching data");
      }
    };

    fetchHello();
  }, []);

  return <h1>{hello || "Loading..."}</h1>;
}
